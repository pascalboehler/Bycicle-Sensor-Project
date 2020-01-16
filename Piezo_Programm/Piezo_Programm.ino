/*
  Created by Laura
  Date created: 16.01.2020
*/
#include "pitches.h"

int Abstand = 0;
int piezoPin = 8;

// Programm Abstandsmesser einfügen
// TODO: Move to func

void setup() {
  pinMode(piezoPin, OUTPUT);
}

void loop() {
  playSound(Abstand);
}

void playSound(int distance) {
  if (Abstand <= 300) {
    tone (piezoPin, NOTE_C5);
    delay (Abstand * 3);
    noTone (piezoPin);
    delay (Abstand * 3);
  } // if not
  else {
    noTone (8);
  }
}
