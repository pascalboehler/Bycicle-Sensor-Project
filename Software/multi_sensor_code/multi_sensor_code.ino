/*
  Created by BSP
  Date created: 16.01.2020
  last editing: 21.02.2020 
*/

int piezoPin = 8;
// Sensor HC SR04
int echo1 = 5;
int trigger1 = 6;
// zweiter Sensor
int echo2 = 4;
int trigger2 = 3;
// dritter Sensor 
int echo3 = 12; 
int trigger3 = 13; 
// led
int led1 = 11;
int led2 = 10;
int led3 = 9; 
// vars
long duration1 = 0;
long duration2 = 0;
long duration3 = 0;
long distance1 = 0;
long distance2 = 0;
long distance3 = 0;

void setup() {
  // Piezo Setup:
  pinMode(piezoPin, OUTPUT);
  // HC Sr04 Setup:
  Serial.begin(9600);
  pinMode(trigger1, OUTPUT);
  pinMode(echo1, INPUT);
  pinMode(trigger2, OUTPUT);
  pinMode(echo2, INPUT);
   pinMode(trigger3, OUTPUT);
  pinMode(echo3, INPUT);
  // LED
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
}

void loop() {
  digitalWrite(trigger1, LOW); // nullen
  delay(5); // wait 5 millisecs
  digitalWrite(trigger1, HIGH); // send "tone"
  delay(10); // wait for 10 secs (tone plays)
  digitalWrite(trigger1, LOW); // stop tone
  duration1 = pulseIn(echo1, HIGH); // check how long needs to come back
  distance1 = duration1*0.03432/2; // calc distance duration * aircoupling speed /2 | s=t*0,034/2
  
  Serial.print("Distance1: ");
  Serial.print(distance1);
  Serial.println(" cm"); 
  if ((distance1 >= 500 || distance1 <= 0)) {
    Serial.println("Error no values found!"); // debug message
  }
  else {
    playSoundAndLight1(distance1);
  }
  //delay(50);

  digitalWrite(trigger2, LOW); // nullen
  delay(5); // wait 5 millisecs
  digitalWrite(trigger2, HIGH); // send "tone"
  delay(10); // wait for 10 secs (tone plays)
  digitalWrite(trigger2, LOW); // stop tone
  duration2 = pulseIn(echo2, HIGH); // check how long needs to come back
  distance2 = duration2* 0.03432/2; // calc distance duration * aircoupling speed/2 | s=t*0,034/2
  
  Serial.print("Distance2: ");
  Serial.print(distance2);
  Serial.println(" cm"); 
  if ((distance2 >= 500 || distance2 <= 0)) {
    Serial.println("Error no values found!"); // debug message
  }
  else {
    playSoundAndLight2(distance2);
  }
  //delay(50);

 digitalWrite(trigger3, LOW); // nullen
  delay(5); // wait 5 millisecs
  digitalWrite(trigger3, HIGH); // send "tone"
  delay(10); // wait for 10 secs (tone plays)
  digitalWrite(trigger3, LOW); // stop tone
  duration3 = pulseIn(echo3, HIGH); // check how long needs to come back
  distance3 = duration3* 0.03432/2; // calc distance duration * aircoupling speed/2 | s=t*0,034/2

  Serial.print("Distance3: ");
  Serial.print(distance3);
  Serial.println(" cm"); 

  Serial.println("-----------------"); 
  if ((distance3 >= 500 || distance3 <= 0)) {
    Serial.println("Error no values found!"); // debug message
  }
  else {
    playSoundAndLight3(distance3);
  }
  //delay(50);
}

void playSoundAndLight1(int distance1) {
  //Serial.println("EXEC");
  if (distance1 <= 150) {
    //Serial.println("EXEC2");
    tone (piezoPin, 2000);
    digitalWrite(led1, HIGH);
    delay (distance1 * 3);
    noTone (piezoPin);
    digitalWrite(led1, LOW);
    delay (distance1 * 3);
  } // if not
  else {
    noTone (8);
  }
}

void playSoundAndLight2(int distance2) {
  //Serial.println("EXEC");
  if (distance2 <= 150) {
    //Serial.println("EXEC2");
    tone (piezoPin, 2000);
    digitalWrite(led2, HIGH);
    delay (distance2 * 3);
    noTone (piezoPin);
    digitalWrite(led2, LOW);
    delay (distance2 * 3);
  } // if not
  else {
    noTone (8);
  }
}

void playSoundAndLight3(int distance3) {
  //Serial.println("EXEC");
  if (distance3 <= 150) {
    //Serial.println("EXEC2");
    tone (piezoPin, 2000);
    digitalWrite(led3, HIGH);
    delay (distance3 * 3);
    noTone (piezoPin);
    digitalWrite(led3, LOW);
    delay (distance3 * 3);
  } // if not
  else {
    noTone (8);
  }
}
