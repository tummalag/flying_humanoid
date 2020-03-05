import serial
import os

if os.name == 'nt':
    import msvcrt
    def getch():
        return msvcrt.getch().decode()
else:
    import termios, fcntl, sys, os
    from select import select
    fd = sys.stdin.fileno()
    old_term = termios.tcgetattr(fd)
    new_term = termios.tcgetattr(fd)

    def getch():   
        new_term[3] = (new_term[3] & ~termios.ICANON & ~termios.ECHO)
        termios.tcsetattr(fd, termios.TCSANOW, new_term)
        try:
            ch = sys.stdin.read(1)
        finally:      
            termios.tcsetattr(fd, termios.TCSADRAIN, old_term)
        return ch
        
    def kbhit():
        new_term[3] = (new_term[3] & ~(termios.ICANON | termios.ECHO))
        termios.tcsetattr(fd, termios.TCSANOW, new_term)
        try:
            dr,dw,de = select([sys.stdin], [], [], 0)
            if dr != []:
                return 1
        finally: 
            termios.tcsetattr(fd, termios.TCSADRAIN, old_term)
            sys.stdout.flush()

        return 0


# Initializing port settings for Arduino
port = "/dev/ttyUSB1"
ser = serial.Serial(port,115200)
ser.flushInput()

while(1):
	if ser.inWaiting()>0:
		force = ser.readStringUntil('\t')
		theta = ser.readStringUntil('\n')
		ser.flushInput()
		print(theta,'\t',force)

		if kbhit():
            	    c = getch()
            	    if c == chr(ESC_ASCII_VALUE):
                        print("STOPPED!!!!")
                	break
