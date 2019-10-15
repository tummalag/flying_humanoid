#include <Servo.h>

const int leftRotor = 9;
const int rightRotor = 8;
Servo left;
Servo right;
const int servoMin = 45;
const int servoMax = 175;
const int binMax = 127

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
    
    if data && 256 == 0: // means data is for right rotor
      serInp = servoInput(data);
      
      
    
    Serial.flush();
  }
  delay(1000);
}

void servoInput(int val){
  serVal = val/binMax *(servoMax - servoMin) + servoMin;
  return serVal;
    
}
