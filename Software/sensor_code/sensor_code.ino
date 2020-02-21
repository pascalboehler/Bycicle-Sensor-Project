/*
  Created by BSP
  Date created: 16.01.2020
  last editing: 21.02.2020 
*/

int piezoPin = 8; // Sensor HC SR04
const int trigger = 6; 
const int echo = 5;

int led = 11; // led

// vars
long duration = 0;
int distance = 0;

void setup() {
  // Piezo Setup:
  pinMode(piezoPin, OUTPUT);
  pinMode(trigger, OUTPUT);// HC Sr04 Setup:
  pinMode(echo, INPUT);
  Serial.begin(9600); //starts the serial communication
  pinMode(led, OUTPUT); // LED
}

void loop() {
  digitalWrite(trigger, LOW); // nullen
  delay(2); // wait 5 millisecs
  
  digitalWrite(trigger, HIGH); // send "tone"
  delay(10); // wait for 10 millisecs (tone plays)
  digitalWrite(trigger, LOW); // stop tone
  
  duration = pulseIn(echo, HIGH); // check how long needs to come back
  distance = duration*0.03432/2; // calc distance (duration / 2) * aircoupling speed
  if (distance >= 500 || distance <= 0) {
    Serial.println("Error no values found!"); // debug message
  }
  else {
    // debug message
    Serial.print("Distance: ");
    Serial.print(distance);
    Serial.println(" cm"); 
    playSoundAndLight(distance);
  }
  //delay(10);
}

void playSoundAndLight(int distance) {
  Serial.println("EXEC");
  if (distance <= 150) {
    Serial.println("EXEC2");
    tone (piezoPin, 2000);
    digitalWrite(led, HIGH);
    delay (distance * 3);
    noTone (piezoPin);
    digitalWrite(led, LOW);
    delay (distance * 3);
  } // if not
  else {
    noTone (8);
  }
}
