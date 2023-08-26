#ifndef IMTURBO_OIL_PUMP_CONTROLLER_HPP
#define IMTURBO_OIL_PUMP_CONTROLLER_HPP

#include <iostream>
#include <string>

#include <wiringPi.h>
#include <boost/asio.hpp>
#include <boost/process.hpp>
namespace bp = boost::process;

#include "utils/app_log.hpp"

namespace ImTurbo {

class OilPumpController {
private:
    AppLog & _app_log;
    std::thread _thread;

public:
    OilPumpController(AppLog & app_log)
        : _app_log(app_log), _thread([this]() {
            bp::opstream in;
            bp::ipstream out;
            bp::ipstream err;

            bp::child c("python odrive_interface/interface.py",
                        bp::std_out > out, bp::std_err > err, bp::std_in < in);

            std::string voltage;
            out >> voltage;
            _app_log.AddLog("[Odrive] VBus Voltage: %s V\n",
                            voltage.c_str());

            c.wait();
        }) {}

    void log() {
        // std::cout << _out.<< std::endl;
        // _app_log.AddLog("%s", value.c_str());
    }
};

}  // namespace ImTurbo

#endif  // IMTURBO_OIL_PUMP_CONTROLLER_HPP