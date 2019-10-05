void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(13,OUTPUT);
  Serial.println("Hello");
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println("Hello inside");
  if(Serial.available()){
    //flash(Serial.parseInt());
    int n = Serial.read();
    Serial.println(n,DEC);
    Serial.print("Flash times:");
    Serial.println(n);
    for(int i = 0; i<n; i++){
      digitalWrite(13,HIGH);
      delay(1000);
      digitalWrite(13,LOW);
      delay(1000);
      Serial.println(i+1);
    }
    Serial.println("Flash complete");
    Serial.flush();
  }
  delay(1000);
}

void flash(int n){
  Serial.print("Flash times:");
  Serial.println(n);
  for(int i = 0; i<n; i++){
    digitalWrite(13,HIGH);
    delay(1000);
    digitalWrite(13,LOW);
    delay(1000);
    Serial.println(i+1);
    }
  Serial.println("Flash complete");
}
