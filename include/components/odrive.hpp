#ifndef IMTURBO_ODRIVE_HPP
#define IMTURBO_ODRIVE_HPP

#include <atomic>
#include <functional>
#include <iostream>
#include <optional>
#include <queue>
#include <string>
#include <thread>
#include <utility>

#include <boost/process.hpp>
namespace bp = boost::process;

#include "utils/app_log.hpp"

namespace ImTurbo {

class Odrive {
private:
    bp::opstream _in;
    bp::ipstream _out;
    bp::ipstream _err;
    bp::child _c;

    AppLog & _app_log;

    std::mutex _m;
    std::condition_variable _cv;
    std::queue<std::pair<
        std::string, std::optional<std::function<void(const std::string &)>>>>
        _async_commands;

    std::jthread _command_thread;
    std::jthread _connection_thread;

public:
    Odrive(AppLog & app_log)
        : _c("python odrive_interface/interface.py", bp::std_out > _out,
             bp::std_err > _err, bp::std_in < _in)
        , _app_log(app_log)
        , _command_thread([this](std::stop_token stoken) {
            std::string buffer;
            bool check;

            // Waiting for odrive connection
            _app_log.AddLog("[Odrive] Searching for odrive connection\n");
            _out >> buffer;
            _app_log.AddLog("[Odrive] Found: %s\n", buffer.c_str());

            // Waiting for motor calibration
            // _app_log.AddLog("[Odrive] Calibrating motors\n");
            // _out >> check;
            // if(!check) {
            //     _app_log.AddLog("[Odrive] ERR: Calibration timed out\n");
            //     return;
            // }
            // _app_log.AddLog("[Odrive] Calibration done\n");

            while(!stoken.stop_requested()) {
                std::unique_lock lk(_m);
                _cv.wait(lk);
                while(!_async_commands.empty()) {
                    auto [command, opt_callback] = _async_commands.front();
                    _async_commands.pop();
                    // do not hold the lock because below are blocking I/O
                    lk.unlock();
                    _in << command << std::endl;
                    _out >> check;
                    if(stoken.stop_requested()) return;
                    if(!check) {
                        _app_log.AddLog("[Odrive] ERR: '%s' failed\n",
                                        command.c_str());
                        _async_commands.pop();
                        continue;
                    }
                    if(opt_callback) {
                        _out >> buffer;
                        if(stoken.stop_requested()) return;
                        opt_callback.value()(buffer);
                    }
                    lk.lock();
                }
                lk.unlock();
            }
        })
        , _connection_thread([this](std::stop_token stoken) {
            bool connected;
            for(;;) {
                _err >> connected;
                if(stoken.stop_requested()) return;
                if(!connected) {
                    _app_log.AddLog("[Odrive] WARN: Odrive connection lost!\n");
                } else {
                    _app_log.AddLog("[Odrive] WARN: Odrive reconnected!\n");
                }
            }
        }) {}

    ~Odrive() {
        _command_thread.request_stop();
        _connection_thread.request_stop();
        _cv.notify_one();
        _c.terminate();
    }

    void send_command(const std::string & cmd,
                      std::function<void(const std::string &)> callback) {
        std::unique_lock lk(_m);
        _async_commands.emplace(cmd, callback);
        lk.unlock();
        _cv.notify_one();
    }
    void send_command(const std::string & cmd) {
        std::unique_lock lk(_m);
        _async_commands.emplace(cmd, std::nullopt);
        lk.unlock();
        _cv.notify_one();
    }
};

}  // namespace ImTurbo

#endif  // IMTURBO_ODRIVE_HPP