#ifndef SENSORS_H
#define SENSORS_H

#include "Arduino.h"
#include "Smoother.h"

#define READ_SENSORS_INTERVAL_MS 10

#define OIL_PRESSURE_A A0

class Sensors {
private:
    unsigned long previousReadMillis;
    Smoother<float, 10> oil_pressure;

public:
    Sensors() { oil_pressure.set(readOilPressure()); }

    void setupPins() { pinMode(OIL_PRESSURE_A, INPUT); }

    void readSensors() {
        previousReadMillis = millis();
        oil_pressure.add(readOilPressure());
    }

    float readOilPressure() {
        return map(analogRead(A0), 102, 922, 0, 6895) / 1000.0;
    }
    float getOilPressure() { return oil_pressure.value(); }

    unsigned long nextReadMillis() {
        return previousReadMillis + READ_SENSORS_INTERVAL_MS;
    }
};

#endif  // SENSORS_H
