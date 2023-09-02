#define MAX_PARTS 4

String command;
char * command_parts[MAX_PARTS + 1];
int command_parts_count;

unsigned long currentMillis = 0;

#include "Sensors.h"

Sensors sensors;

void setup() {
    pinMode(LED_BUILTIN, OUTPUT);
    sensors.setupPins();

    Serial.begin(57600);
    while(!Serial) {
        delay(1);
    }
    // handshake
    while(Serial.available() <= 0) {
        Serial.print('\n');
        delay(100);
    }
    Serial.read();
    Serial.print('\n');
    command = String("");
}

void loop() {
    currentMillis = millis();
    if(Serial.available() > 0) {
        char inChar = Serial.read();
        command += inChar;
        if(inChar == '\n') {
            splitCommand();
            handleCommand();
            command = "";
        }
    }
    if(currentMillis >= sensors.nextReadMillis()) {
        sensors.readSensors();
    }
}

void splitCommand() {
    command_parts[0] = &command[0];
    command_parts_count = 1;
    for(int i = 0;; ++i) {
        if(command[i] == ' ' || command[i] == '\n') {
            command_parts[command_parts_count] = &command[i] + 1;
            if(command[i] == '\n' || command_parts_count == MAX_PARTS) {
                command[i] = '\0';
                break;
            }
            command[i] = '\0';
            command_parts_count += 1;
        }
    }
}

void handleCommand() {
    switch(command[0]) {
        case 'g':
            Serial.print("OK\n");
            Serial.print("{\"oil_pressure\":");
            Serial.print(sensors.getOilPressure());
            Serial.print("}\n");
            return;
        case 'r':
            Serial.print(command);
            return;
        case 'v': {
            char * e = NULL;
            float pos = strtod(command_parts[1], &e);
            if(e == command_parts[1]) {
                Serial.print("Nan\n");
                return;
            }
            Serial.print("OK\n");
            return;
        }
        default:
            Serial.print("unknown command\n");
    }
}
