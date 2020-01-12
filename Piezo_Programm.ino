/*

*/
#include "pitches.h"

int Abstand = 0;

// Programm Abstandsmesser einfügen

void setup() {
  
}

void loop() {
    
    if (Abstand <= 300){
      tone (8, NOTE_C5);
      delay (Abstand * 3);
      noTone (8);
      delay (Abstand * 3);
    }
    else{
      noTone (8);
    }
    
}
