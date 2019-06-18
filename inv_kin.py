import ctypes
import os
import numpy as np
import time

if os.name == 'nt':
    import msvcrt
    def getch():
        return msvcrt.getch().decode()
else:
    import sys, tty, termios
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    def getch():
        try:
            tty.setraw(sys.stdin.fileno())
            ch = sys.stdin.read(1)
        finally:
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
        return ch

from dynamixel_sdk import *                    # Uses Dynamixel SDK library

# Length of the arms in inches
a0              = 2   
a1              = 7
a2              = 3
# Angles of the joints
t0              = 180
t1              = 180 
t2              = 180

# Angles in radians
t0      = t0/180*np.pi
t1      = t1/180*np.pi
t2      = t2/180*np.pi
