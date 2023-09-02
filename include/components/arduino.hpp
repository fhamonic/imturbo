#ifndef IMTURBO_ARDUINO_HPP
#define IMTURBO_ARDUINO_HPP

#include <condition_variable>
#include <functional>
#include <optional>
#include <queue>
#include <string>
#include <thread>
#include <utility>

#include <libserial/SerialPort.h>

#include "utils/app_log.hpp"

namespace ImTurbo {

class Arduino {
private:
    std::string _port_path;
    LibSerial::SerialPort serial_port;

    AppLog & _app_log;

    std::mutex _m;
    std::condition_variable _cv;
    std::queue<std::pair<
        std::string, std::optional<std::function<void(const std::string &)>>>>
        _async_commands;

    std::jthread _command_thread;

public:
    Arduino(const std::string & port_path, AppLog & app_log)
        : _port_path(port_path), _app_log(app_log) {
        _command_thread = std::jthread([this](std::stop_token stoken) {
            if(!connectSerialPort()) {
                _app_log.AddLog("[Arduino] Unable to open port '%s'\n",
                                _port_path.c_str());
                return;
            }

            while(!stoken.stop_requested()) {
                std::unique_lock lk(_m);
                _cv.wait(lk);
                while(!_async_commands.empty()) {
                    auto [command, opt_callback] = _async_commands.front();
                    // do not hold the lock because below are blocking I/O
                    lk.unlock();
                    try {
                        serial_port.Write(command);
                        serial_port.WriteByte('\n');
                        std::string check;
                        serial_port.ReadLine(check, '\n', 20);
                        check.pop_back();
                        if(check != "OK") {
                            _app_log.AddLog(
                                "[Arduino] ERR: '%s' failed: '%s'\n",
                                command.c_str(), check.c_str());
                            lk.lock();
                            _async_commands.pop();
                            continue;
                        }
                        if(opt_callback) {
                            std::string response;
                            serial_port.ReadLine(response, '\n', 20);
                            response.pop_back();
                            if(stoken.stop_requested()) return;
                            opt_callback.value()(response);
                        }

                    } catch(const std::runtime_error &) {
                        _app_log.AddLog(
                            "[Arduino] Serial connection is lost or timed "
                            "out!\n");
                        serial_port.Close();
                        _app_log.AddLog(
                            "[Arduino] Waiting for '%s' to reappear\n",
                            _port_path.c_str());
                        while(!stoken.stop_requested() && !connectSerialPort())
                            std::this_thread::sleep_for(
                                std::chrono::milliseconds(100));
                        lk.lock();
                        continue;
                    }
                    std::this_thread::sleep_for(std::chrono::milliseconds(100));
                    lk.lock();
                    _async_commands.pop();
                }
                lk.unlock();
            }
        });
    }

    ~Arduino() {
        _command_thread.request_stop();
        _cv.notify_one();
    }

    bool connectSerialPort() {
        try {
            serial_port.Open(_port_path);

            serial_port.SetBaudRate(LibSerial::BaudRate::BAUD_57600);
            serial_port.SetCharacterSize(LibSerial::CharacterSize::CHAR_SIZE_8);
            serial_port.SetFlowControl(
                LibSerial::FlowControl::FLOW_CONTROL_NONE);
            serial_port.SetParity(LibSerial::Parity::PARITY_NONE);
            serial_port.SetStopBits(LibSerial::StopBits::STOP_BITS_1);

            arduinoHandshake();
        } catch(const std::runtime_error &) {
            if(serial_port.IsOpen()) serial_port.Close();
            return false;
        }
        return true;
    }

    void arduinoHandshake() {
        char buf;
        _app_log.AddLog("[Arduino] Establishing serial connection\n");
        serial_port.ReadByte(buf);
        serial_port.Write("\n");
        do {
            serial_port.ReadByte(buf);
        } while(serial_port.IsDataAvailable());
        _app_log.AddLog("[Arduino] Connection established!\n");
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

#endif  // IMTURBO_ARDUINO_HPP