#include <Servo.h>

const int leftRotor = 9;
const int rightRotor = 8;
Servo left;
Servo right;
const float servoMin = 45;
const float servoMax = 175;
const float binMax = 127;
int potentiometerPin = A1;
int potentiometerValue = 0;
const int potMinVal = 250;
const int potMaxVal = 850;
const int potStableVal = 550;
int prev_err_r = 0; 
int prev_err_l = 0; 
const int kp = 5;
const int kd = 0;
const int ki = 0;
const int dt = 500; // 0.5 sec
float i_err_r = 0;
float i_err_l = 0;



void setup() {
  // put your setup code here, to run once:
  pinMode(leftRotor,OUTPUT);
  pinMode(rightRotor,OUTPUT);
  left.attach(leftRotor);
  right.attach(rightRotor);
  left.write(servoMin);
  right.write(servoMin);
  Serial.begin(9600);
  Serial.println("Bot is ready to fly!!");
}

void loop() {
  // put your main code here, to run repeatedly:
  potentiometerValue = analogRead(potentiometerPin);
  Serial.println(potentiometerValue);
  if (potentiometerValue > 570){
    int error = potentiometerValue - potStableVal;
    int thrustR = getThrustValR(error);
    right.write(thrustR);
    Serial.print("Right \t");
    Serial.print(thrustR);
  }
  if (potentiometerValue < 530){
    int error = potStableVal - potentiometerValue;
    int thrustL = getThrustValL(error);   
    left.write(thrustL);
    Serial.print("Left \t");
    Serial.print(thrustL); 
  }
  Serial.flush();
  delay(dt);
}

int getThrustValR(float error_r){
  /*  This function takes the potentiometer value and 
   *  calculates the thrust value for right thruster with PID controller
   * thrust has the pwm value required to control the rotor for the potentiometer value
   */
  float p_err_r = kp*error_r;
  float d_err_r = kd*(error_r - prev_err_r)/(dt/1000);
  float i_err_r =+ ki*error_r;
  float pid_err_r = p_err_r + d_err_r + i_err_r;
  
  float thrust_r = pid_err_r/(potMaxVal - potStableVal) * (servoMax - servoMin) + servoMin ;
  if (thrust_r > 100);{
      thrust_r = 100;
  }
  prev_err_r = error_r;
  return thrust_r;
}

int getThrustValL(float error_l){
  /*  This function takes the potentiometer value and 
   *  calculates the thrust value for left thruster with PID controller
   * thrust has the pwm value required to control the rotor for the potentiometer value
   */
  float p_err_l = kp*error_l;
  float d_err_l = kd*(error_l - prev_err_l)/(dt/1000);
  float i_err_l =+ ki*error_l;
  float pid_err_l = p_err_l + d_err_l + i_err_l;
  
  float thrust_l = pid_err_l/(potMaxVal - potStableVal) * (servoMax - servoMin) + servoMin ;
  if (thrust_l > 100);{
      thrust_l = 100;
  }
  prev_err_l = error_l;
  return thrust_l;
}
