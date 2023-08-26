import sys

import odrive
# from odrive.enums import *

odrv0 = odrive.find_any()  
sys.stdout.write(str(odrv0.vbus_voltage)+'\n')