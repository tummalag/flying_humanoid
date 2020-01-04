#include <Servo.h>

// Desired Values
double theta_D = 0.0;         // angle in degree

const int mot[] = {9,10}; // Initializing motor pins
const int mot_L = 0;      // mot[mot_L] is to control left motor.
const int mot_R = 1;      // similarly for right motor

const double mot_PWM_offset[] = {50,60}; // Motor offset value.

Servo left;               // Creating 2 servos left and right
Servo right;
const double servoMin = 0.0;  // servo PWM min value
const double servoMax = 60.0; // servo PWM max value

int potentiometerPin = A1;
const int potRefVal = 550;  // Refereance Value
const int potMinVal = 250;  // Left most value -45 degree
const int potMaxVal = 850;  // Right most value +45 degree

// Gain constants
const double kp = 0.0050;
const double ki = 0.0001;
double i_err = 0.0;

double getAngle() {
  int potentiometerValue = analogRead(potentiometerPin);
  double degree = enc2deg(potentiometerValue);
  //Serial.println(potentiometerValue);
  return degree;
}

double enc2deg(double enc){
  double deg = (enc - potRefVal)/(potRefVal - potMinVal)*30;
  return deg;
}

int val2PWM(double val){
  double thrustInPWM = val * (servoMax - servoMin) + servoMin ;
  if( thrustInPWM > servoMax ) thrustInPWM = servoMax;
  if( thrustInPWM < servoMin ) thrustInPWM = servoMin;
  return (int)thrustInPWM;
}

int setMotor(double val){
  double absVal = abs(val);
  if (val > 1.0){
    val =  1.0;
  }
  if (val < -1.0){
    val =  -1.0;
  }
  if (val > 0.0){
    setMotorThrust(mot[mot_L],absVal);
    setMotorThrust(mot[mot_R],servoMin);
    return 0;
  }
   if(val <= 0.0){
    setMotorThrust(mot[mot_R],absVal);
    setMotorThrust(mot[mot_L],servoMin);
    return 0;
  } 
  return 1;
}

int setMotorThrust(int servo, double err){
  if (servo == mot[mot_L]){
    int thrust = val2PWM(err);
    left.write(thrust + mot_PWM_offset[mot_L]);
    Serial.print("left   ");
    Serial.println(thrust);
    return 0;
  }
  if (servo == mot[mot_R]){
    int thrust = val2PWM(err);
    right.write(thrust + mot_PWM_offset[mot_R]);
    Serial.print("right   ");
    Serial.println(thrust);
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
  left.write(45);
  right.write(45);
  delay(1000);
  left.write(servoMax + mot_PWM_offset[mot_L]);
  right.write(servoMax + mot_PWM_offset[mot_R]);
  delay(1000);
}

void loop() {
  double theta = getAngle();
  double error = theta_D - theta;
  i_err += ki*error;
  double p_err = kp*error;
  double c = p_err + i_err;
  setMotor(c);
  Serial.print(theta);
  Serial.print(' ');
  Serial.println(c);
  delay(10);
}
