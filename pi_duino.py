#  This program should be running in the Raspberry pi. 
#  This program sends 1 Byte of data to arduino 
#  Input is given in the percetage of the rotor max output.
#  It converts to the respective binary value in using 
#  Least Significant 7 Bits and Most Sognificant bit says which rotor it should rotate.
#  0 - Right and 1 - Left
#  Output will be, it sends a 1 Byte of data using Serial conncetion.

# Libraries used
import serial
import time

# Initializing port settings
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
            
            if rotor == 'Left' | rotor == 'left' | rotor = 'l':
                sendingByte = 1 << 7 | speedVal
                
            elif rotor == 'Right' | rotor == 'right' | rotor = 'r':
                sendingByte = 0 <<7 | speedVal
            
            else:
                print("Wrong input please try again")
                break:
                    
            ser.write('%d' %sendingByte)
            print(sendingByte)
         
        except:
             print("Input error")
                ser.write('0')
