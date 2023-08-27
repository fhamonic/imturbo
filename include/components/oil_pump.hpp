#ifndef IMTURBO_OIL_PUMP_HPP
#define IMTURBO_OIL_PUMP_HPP

#include <atomic>
#include <iostream>
#include <string>

#include <wiringPi.h>
#include <boost/asio.hpp>
#include <boost/process.hpp>
namespace bp = boost::process;

#include "components/odrive.hpp"
#include "utils/app_log.hpp"

namespace ImTurbo {

class OilPump {
private:
    AppLog & _app_log;
    Odrive & _odrive;
    std::atomic<float> _oil_pump_speed;

public:
    OilPump(AppLog & app_log, Odrive & odrive)
        : _app_log(app_log), _odrive(odrive), _oil_pump_speed(0.0f) {}

    void set_speed(float speed) {
        _odrive.send_command("v 0 " + std::to_string(speed));
    }
    float get_speed() { return _oil_pump_speed; }
};

}  // namespace ImTurbo

#endif  // IMTURBO_OIL_PUMP_HPP