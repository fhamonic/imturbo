import sys
import time

import odrive
from odrive.enums import *

def poutln(s):
    sys.stdout.write(str(s)+'\n')
    sys.stdout.flush()

def perrln(s):
    sys.stderr.write(str(s)+'\n')
    sys.stderr.flush()

## Searching odrive connection
try:
    odrv0 = odrive.find_any(timeout=10)
except:
    poutln(0)
    exit()
    
odrv_connected = True
poutln(1)
ordv_serial_number = odrv0._serial_number
poutln(ordv_serial_number)

def reconnect(x):
    global odrv_connected
    odrv_connected = False

odrv0._on_lost.add_done_callback(reconnect)

## Waiting motor calibration
# t0 = time.time()
# while odrv0.axis0.current_state != AxisState.CLOSED_LOOP_CONTROL:
#     time.sleep(0.1)
#     if time.time() - t0 > 10:
#         poutln(0)
#         exit()
# poutln(1)

for line in sys.stdin:
    parts = line[:-1].split(' ')
    while True:
        if not odrv_connected:
            odrv0 = odrive.find_any(serial_number=ordv_serial_number)
            odrv_connected = True
        try:
            match parts:
                case ["v"]:
                    poutln(1)
                    poutln(odrv0.vbus_voltage)
                case ["s", 0, speed]:
                    odrv0.axis0.controller.input_vel = speed
                    poutln(1)
                case ["s", 1, speed]:
                    odrv0.axis1.controller.input_vel = speed
                    poutln(1)
                case _:
                    poutln(0)
            break
        except:
            continue
