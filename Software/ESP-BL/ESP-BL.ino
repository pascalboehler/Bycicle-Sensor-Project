#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

void setup() {
  SerialBT.begin("ESP32");
}

void loop() {
  
  SerialBT.println(random(100));
 
  delay(1000);
}
