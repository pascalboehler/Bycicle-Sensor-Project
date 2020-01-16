/*
  Created by Pascal Böhler
  Date created: 16.01.2020
*/

int piezoPin = 8;
// Sensor HC SR04
int echo = 5;
int trigger = 6;
int led = 11;
long duration = 0;
long distance = 0;


// Programm Abstandsmesser einfügen
// TODO: Move to func

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
  digitalWrite(trigger, LOW);
  delay(5);
  digitalWrite(trigger, HIGH);
  delay(10); //Dieser „Ton“ erklingt für 10 Millisekunden.
  digitalWrite(trigger, LOW);//Dann wird der „Ton“ abgeschaltet.
  duration = pulseIn(echo, HIGH); //Mit dem Befehl „pulseIn“ zählt der Mikrokontroller die Zeit in Mikrosekunden, bis der Schall zum Ultraschallsensor zurückkehrt.
  distance = (duration/2) * 0.03432; //Nun berechnet man die Entfernung in Zentimetern. Man teilt zunächst die Zeit durch zwei (Weil man ja nur eine Strecke berechnen möchte und nicht die Strecke hin- und zurück). Den Wert multipliziert man mit der Schallgeschwindigkeit in der Einheit Zentimeter/Mikrosekunde und erhält dann den Wert in Zentimetern.
  if (distance >= 500 || distance <= 0)
  {
    Serial.println("Kein Messwert");
  }
  else
  {
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
