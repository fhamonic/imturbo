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

    std::jthread _thread;

public:
    Odrive(AppLog & app_log)
        : _c("python odrive_interface/interface.py", bp::std_out > _out,
             bp::std_err > _err, bp::std_in < _in)
        , _app_log(app_log)
        , _thread([this](std::stop_token stoken) {
            std::string buffer;
            bool check;

            // Waiting for odrive connection
            _app_log.AddLog("[Odrive] Searching for odrive connection\n");
            _out >> check;
            if(!check) {
                _app_log.AddLog("[Odrive] ERR: Search timed out\n");
                return;
            }
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
                    auto & [command, opt_callback] = _async_commands.front();
                    _in << command << std::endl;
                    _out >> check;
                    if(!check) {
                        _app_log.AddLog("[Odrive] ERR: '%s' failed\n",
                                        command.c_str());
                        _async_commands.pop();
                        continue;
                    }
                    if(opt_callback) {
                        _out >> buffer;
                        opt_callback.value()(buffer);
                    }
                    _async_commands.pop();
                }
                lk.unlock();
            }
        }) {}

    ~Odrive() {
        _c.terminate();
        _cv.notify_one();
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