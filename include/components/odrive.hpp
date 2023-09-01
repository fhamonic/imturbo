#ifndef IMTURBO_ODRIVE_HPP
#define IMTURBO_ODRIVE_HPP

#include <condition_variable>
#include <functional>
#include <optional>
#include <queue>
#include <string>
#include <thread>
#include <utility>

#include <Poco/PipeStream.h>
#include <Poco/Process.h>

#include "utils/app_log.hpp"

namespace ImTurbo {

class Odrive {
private:
    Poco::Pipe inPipe;
    Poco::Pipe outPipe;
    Poco::Pipe errPipe;
    Poco::Process::Args args;
    Poco::ProcessHandle ph;
    Poco::PipeOutputStream inPipeStream;
    Poco::PipeInputStream outPipeStream;
    Poco::PipeInputStream errPipeStream;

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
        : args({"interfaces/odrive_proxy.py"})
        , ph(Poco::Process::launch("python3.10", args, &inPipe, &outPipe,
                                   &errPipe))
        , inPipeStream(inPipe)
        , outPipeStream(outPipe)
        , errPipeStream(errPipe)
        , _app_log(app_log)
        , _command_thread([this](std::stop_token stoken) {
            std::string buffer;
            bool check;

            // Waiting for odrive connection
            _app_log.AddLog("[Odrive] Searching for odrive connection\n");
            outPipeStream >> buffer;
            _app_log.AddLog("[Odrive] Found: %s\n", buffer.c_str());

            // Waiting for motor calibration
            // _app_log.AddLog("[Odrive] Calibrating motors\n");
            // outPipeStream >> check;
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
                    inPipeStream << command << std::endl;
                    outPipeStream >> check;
                    if(stoken.stop_requested()) return;
                    if(!check) {
                        _app_log.AddLog("[Odrive] ERR: '%s' failed\n",
                                        command.c_str());
                        _async_commands.pop();
                        continue;
                    }
                    if(opt_callback) {
                        outPipeStream >> buffer;
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
                errPipeStream >> connected;
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
        Poco::Process::kill(ph);
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