import serial
ser = serial.Serial('/dev/ttyUSB1', 115200)
while 1: 
    if(ser.in_waiting >0):
        number = ser.readline()
	flt_num = float(number)
	num = flt_num**2
	print(flt_num, type(flt_num),num)

