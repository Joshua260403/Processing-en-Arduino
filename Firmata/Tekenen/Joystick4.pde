/*
arduino_input
 
 Demonstrates the reading of digital and analog pins of an Arduino board
 running the StandardFirmata firmware.
 
 To use:
 * Using the Arduino software, upload the StandardFirmata example (located
 in Examples > Firmata > StandardFirmata) to your Arduino board.
 * Run this sketch and look at the list of serial ports printed in the
 message area below. Note the index of the port corresponding to your
 Arduino board (the numbering starts at 0).  (Unless your Arduino board
 happens to be at index 0 in the list, the sketch probably won't work.
 Stop it and proceed with the instructions.)
 * Modify the "arduino = new Arduino(...)" line below, changing the number
 in Arduino.list()[0] to the number corresponding to the serial port of
 your Arduino board.  Alternatively, you can replace Arduino.list()[0]
 with the name of the serial port, in double quotes, e.g. "COM5" on Windows
 or "/dev/tty.usbmodem621" on Mac.
 * Run this sketch. The squares show the values of the digital inputs (HIGH
 pins are filled, LOW pins are not). The circles show the values of the
 analog inputs (the bigger the circle, the higher the reading on the
 corresponding analog input pin). The pins are laid out as if the Arduino
 were held with the logo upright (i.e. pin 13 is at the upper left). Note
 that the readings from unconnected pins will fluctuate randomly. 
 
 For more information, see: http://playground.arduino.cc/Interfacing/Processing
 */

import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

color off = color(4, 79, 111);
color on = color(84, 145, 158);

void setup() {
  size(512, 512);

  // Prints out the available serial ports.
  println(Arduino.list());

  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, "COM5", 57600); //SERIELE POORT

  // Alternatively, use the name of the serial port corresponding to your
  // Arduino (in double-quotes), as in the following line.
  //arduino = new Arduino(this, "/dev/tty.usbmodem621", 57600);

  // Set the Arduino digital pins as inputs.
  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.INPUT);

  noStroke();

  background(255);
}

float plusx = 0;     
float plusy = 0;  

float size;

boolean kleuren = true;

float x = 256;
float y = 256;

float colorR = 0;
float colorG = 0;
float colorB = 0;

boolean opnieuw = false;

void draw() {
  println(arduino.analogRead(1));
  println(arduino.analogRead(0));
  println("--");
  println(plusx);
  println(plusy);
  println("--");
  println(arduino.analogRead(2));
  println(arduino.analogRead(3));
  println("----");
  println(map((arduino.analogRead(1)), 0, 1023.2, 0, 1024));
  println(map((arduino.analogRead(0)), 0, 1023.2, 0, 1024));
  println("------");

  if (map((arduino.analogRead(1)), 0, 1023.2, 0, 1024) >= 520) {
    x = x + plusx;
  }
  if (map((arduino.analogRead(1)), 0, 1023.2, 0, 1024) <= 505) {
    x = x + plusx;
  }

  
  if (map((arduino.analogRead(0)), 0, 1023.2, 0, 1024) >= 520) {
    y = y - plusy;
  }
  if (map((arduino.analogRead(0)), 0, 1023.2, 0, 1024) <= 505) {
    y = y - plusy;
  }

  plusx = (map((arduino.analogRead(1)), 0, 1023.2, 0, 1024)-503)/128;
  plusy = (map((arduino.analogRead(0)), 0, 1023.2, 0, 1024)-508)/128;

  size = (1023-arduino.analogRead(3))/5;

  if (kleuren == true) {
    if (arduino.analogRead(3) > 512) {
      fill(colorR, colorG, colorB);
      ellipse(x, y, size/2, size/2);
    }
    if (arduino.analogRead(3) <= 512) {
      fill(colorR, colorG, colorB);
      rect(x, y, size/2, size/2);
    }
  }
if (opnieuw == false) {
  if (arduino.analogRead(2) == 1023) {
    delay(50);
    if (arduino.analogRead(2) == 1023) {
      delay(50);
      if (arduino.analogRead(2) == 1023) {
        colorR = random(0, 255);
        colorG = random(0, 255);
        colorB = random(0, 255);
        if (colorR + colorB + colorG >= 740) {
          colorR = random(25, 230);
          colorG = random(25, 230);
          colorB = random(25, 230);
        }
        if (colorR + colorB + colorG <= 50) {
          colorR = random(25, 230);
          colorG = random(25, 230);
          colorB = random(25, 230);
        }
        kleuren = true;
        if (arduino.analogRead(2) == 1023) {
          delay(500);
          if (arduino.analogRead(2) == 1023) {
            kleuren = false;
            delay(500);
            if (arduino.analogRead(2) == 1023) {
              background(0);
              delay(500);
              background(255);
              if (arduino.analogRead(2) == 1023) {
                delay(50);
                if (arduino.analogRead(2) == 1023) {
                  delay(50);
                  if (arduino.analogRead(2) == 1023) {
                    delay(50);
                    if (arduino.analogRead(2) == 1023) {
                      delay(50);
                      if (arduino.analogRead(2) == 1023) {
                        delay(50);
                        if (arduino.analogRead(2) == 1023) {
                          x = 256;
                          y = 256;
                          kleuren = true;
                          opnieuw = true;
                        }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  else {
    if (arduino.analogRead(2) != 1023) {
      opnieuw = false;
    }
  }
}