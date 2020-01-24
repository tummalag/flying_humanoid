import serial
ser = serial.Serial('/dev/ttyUSB1', 115200)
while 1: 
    if(ser.in_waiting >0):
        number = ser.readline()
	flt_num = float(number)
	print(flt_num)
	print(type(flt_num))

