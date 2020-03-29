// Example by Tom Igoe
import java.*;
import processing.serial.*;

Serial myPort;  // The serial port

void setup() {
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  while (myPort.available() > 0) {
    int inByte = myPort.read();
    int inInt = Character.getNumericValue(inByte);

    if (inByte != 0){
      println(inByte);
    }
    // println(inInt);

    //String inString = myPort.readString();
    //println(int(inString));
  }
}
