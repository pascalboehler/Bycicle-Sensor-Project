#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

void setup() {
  SerialBT.begin("ESP32");
  Serial.begin(9600); 
}

void loop() {
  int RandomNumber = random(100);
  SerialBT.print("t");
  SerialBT.write(RandomNumber);
  SerialBT.write(RandomNumber+1);
  SerialBT.write(RandomNumber+2);
  Serial.println(RandomNumber);
 
  delay(100);
}
