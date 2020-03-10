#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

void setup() {
  SerialBT.begin("ESP32");
  Serial.begin(9600); 
}

void loop() {
  int RandomNumber = random(100);
  SerialBT.print("f");
  SerialBT.println(RandomNumber);
  SerialBT.println(RandomNumber+1);
  SerialBT.println(RandomNumber+2);
  Serial.println(RandomNumber);
 
  delay(100);
}
