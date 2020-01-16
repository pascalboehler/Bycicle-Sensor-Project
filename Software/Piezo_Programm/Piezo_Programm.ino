/*
  Created by Laura
  Date created: 16.01.2020
*/

int Abstand = 0;
int piezoPin = 8;

// Programm Abstandsmesser einfügen
// TODO: Move to func

void setup() {
  pinMode(piezoPin, OUTPUT);
  
}

void loop() {
  for(int i = 500; i > 250; i--) {
    playSound(Abstand);
  }
}

void playSound(int distance) {
  if (Abstand <= 150) {
    tone (piezoPin, 800);
    delay (Abstand * 3);
    noTone (piezoPin);
    delay (Abstand * 3);
  } // if not
  else {
    noTone (8);
  }
}
