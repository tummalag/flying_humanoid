#include <Servo.h>

// Desired Values
double theta_D = 0.0;         // angle in degree

const int mot[] = {9,10}; // Initializing motor pins
const int mot_L = 0;      // mot[mot_L] is to control left motor.
const int mot_R = 1;      // similarly for right motor

Servo left;               // Creating 2 servos left and right
Servo right;
const double servoMin = 45;  // servo PWM min value
const double servoMax = 100; // servo PWM max value

int potentiometerPin = A1;
const int potRefVal = 550;  // Refereance Value
const int potMinVal = 250;  // Left most value -45 degree
const int potMaxVal = 850;  // Right most value +45 degree

const double deg_threshold = 5.0;

// Gain constants
const double kp = 0.020;

double getAngle() {
  int potentiometerValue = analogRead(potentiometerPin);
  double degree = enc2deg(potentiometerValue);
  //Serial.println(potentiometerValue);
  return degree;
}

double enc2deg(double enc){
  double deg = (enc - potRefVal)/(potRefVal - potMinVal)*45;
  return deg;
}

int val2PWM(double val){
  double thrustInPWM = val * (servoMax - servoMin) + servoMin ;
  if( thrustInPWM > servoMax ) thrustInPWM = servoMax;
  if( thrustInPWM < servoMin ) thrustInPWM = servoMin;
  return (int)thrustInPWM;
}

int setMotor(double err){
  double absErr = abs(err);
  if (err > 1.0){
    err =  1.0;
  }
  if (err < -1.0){
    err =  -1.0;
  }
  if (err > 0.0){
    setMotorThrust(mot[mot_L],absErr);
    setMotorThrust(mot[mot_R],0.0);
    return 0;
  }
  if(err <= 0.0){
    setMotorThrust(mot[mot_R],absErr);
    setMotorThrust(mot[mot_L],0.0);
    return 0;
  } 
  return 1;
}

int setMotorThrust(int servo, double err){
  if (servo == mot[mot_L]){
    int thrust = val2PWM(err);
    left.write(thrust);
    return 0;
  }
  if (servo == mot[mot_R]){
    int thrust = val2PWM(err);
    right.write(thrust);
    return 0;
  }
  return 1;
}

void setup() {
  Serial.begin(115200);
  Serial.println("Bot is ready to fly!!");
  pinMode(mot[mot_L],OUTPUT);
  pinMode(mot[mot_R],OUTPUT);
  left.attach(mot[mot_L]);
  right.attach(mot[mot_R]);
  left.write(servoMin);
  right.write(servoMin);
  
}

void loop() {
  double theta = getAngle();
  double error = theta_D - theta;
  double c = kp*error;
  setMotor(c);
  Serial.println(theta);
  delay(10);
}
