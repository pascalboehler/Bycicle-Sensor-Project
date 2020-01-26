/*
 Demo for RGB-LED-Modul.
 Plug the board directly in your Arduino board without using
 cables. If you turn the board 180° you should use pin 12 as
 ground and swap the green and blue pin.
 The demo will over time cycle through all the 16777216
 different colors which can be made with 3x8bit.
 */
int groundpin = 8; // write 0 to get ground
int greenpin = 9; // select the pin for the green LED
int redpin = 10; // select the pin for the red LED
int bluepin = 11; // select the pin for the blue LED
 
void setup () {
  pinMode (redpin, OUTPUT);
  pinMode (greenpin, OUTPUT);
  pinMode (bluepin, OUTPUT);
  pinMode (groundpin, OUTPUT);
  digitalWrite (groundpin, LOW);
}
 
void loop () {
  analogWrite (greenpin, 100); 
  delay (400);
}
