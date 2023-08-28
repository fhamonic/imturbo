#ifndef IMTURBO_OIL_PRESSURE_SENSOR_HPP
#define IMTURBO_OIL_PRESSURE_SENSOR_HPP

#include <atomic>
#include <thread>

#include "utils/app_log.hpp"

namespace ImTurbo {

class OilPump {
private:
    AppLog & _app_log;
    std::atomic<float> _oil_pressure;

public:
    OilPump(AppLog & app_log)
        : _app_log(app_log), _oil_pressure(0.0f) {}
    
    float get_pressure() const { return _oil_pressure; }
};

}  // namespace ImTurbo

#endif  // IMTURBO_OIL_PRESSURE_SENSOR_HPP