import serial
import time

port = "/dev/ttyUSB0"

ser = serial.Serial(port,9600)
ser.flushInput()

while True:
    if ser.inWaiting()>0:
        inputValue = ser.readline()
        print(inputValue)
        try:
            rotor = input("Provide Left or Right rotor : ")
            rotSpeed = int(input("Provide the rotation speed in '%' : "))
            
            speedVal = int(rotSpeed*127/100)
            
            if rotor == 'Left' | rotor == 'left':
                sendingByte = 1 << 7 | speedVal
                
            else:
                sendingByte = 0 <<7 | speedVal
            
            ser.write('%d' %sendingByte)
         
        except:
             print("Input error")
                ser.write('0')
