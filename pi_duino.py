import serial
import time

port = "/dev/ttyUSB2"

ser = serial.Serial(port,9600)
ser.flushInput()

comp_list = ["Flash complete\r\n", "Hello\r\n", "Hello inside\r\n"]
while True:
    if ser.inWaiting()>0:
        inputValue = ser.readline()
        print(inputValue)
        if inputValue in comp_list:
            try:
               n = input("Set the arduino flash times:")
               ser.write('%d' %n)

            except:
               print("Input error")
               ser.write('0')
