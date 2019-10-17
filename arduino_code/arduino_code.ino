#include <Servo.h>

const int leftRotor = 9;
const int rightRotor = 8;
Servo left;
Servo right;
const float servoMin = 45;
const float servoMax = 175;
const float binMax = 127;

void setup() {
  // put your setup code here, to run once:
  pinMode(leftRotor,OUTPUT);
  pinMode(rightRotor,OUTPUT);
  left.attach(leftRotor);
  right.attach(rightRotor);
  Serial.begin(9600);
  Serial.println("Hello");
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available()){
    int data = Serial.parseInt();
    
    if( data < 128){ // means data is for right rotor
      int servoInp = servoInput(data);
      left.write(servoInp);
      Serial.print("Left \t");
      Serial.print(data);
      Serial.print("\t");
      Serial.println(servoInp);
      delay(100);
    }

    else{ // means data is for left rotor
      int servoInp = servoInput(data - 128);
      right.write(servoInp);
      Serial.print("Right \t");
      Serial.print(data -128);
      Serial.print("\t");
      Serial.println(servoInp);
      delay(100);
    }
  }
  Serial.flush();
  delay(1000);
}

int servoInput(float val){
  float servoVal = val/binMax *(servoMax - servoMin) + servoMin;
  //Serial.print(servoVal);
  return servoVal;
    
}
