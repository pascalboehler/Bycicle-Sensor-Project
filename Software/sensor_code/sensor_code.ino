/*
  Created by Pascal Böhler
  Date created: 16.01.2020
*/

int piezoPin = 8;
// Sensor HC SR04
int echo = 5;
int trigger = 6;
// led
int led = 11;
// vars
long duration = 0;
long distance = 0;

void setup() {
  // Piezo Setup:
  pinMode(piezoPin, OUTPUT);
  // HC Sr04 Setup:
  Serial.begin(9600);
  pinMode(trigger, OUTPUT);
  pinMode(echo, INPUT);
  // LED
  pinMode(led, OUTPUT);
}

void loop() {
  digitalWrite(trigger, LOW); // nullen
  delay(5); // wait 5 millisecs
  digitalWrite(trigger, HIGH); // send "tone"
  delay(10); // wait for 10 secs (tone plays)
  digitalWrite(trigger, LOW); // stop tone
  duration = pulseIn(echo, HIGH); // check how long needs to come back
  distance = (duration/2) * 0.03432; // calc distance (duration / 2) * aircoupling speed
  if (distance >= 500 || distance <= 0) {
    Serial.println("Error no values found!"); // debug message
  }
  else {
    Serial.println(distance + " cm"); // debug message
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
