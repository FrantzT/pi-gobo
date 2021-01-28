void action() { 
/*********** Put what you want the code to do with the values (dmxvalue) here *************
example code: print out the received values to the serial port, and set PWM pins 5 and 6 
to the first two values received.  You can take this code out and put your own in.*/

//begin example code
//for(byte j = 0; j < NUMBER_OF_CHANNELS; j++) {
  /* You'll need to use a program like Putty that allows you to set custom baud rates
   * in order to communicate with the Arduino over serial; the Arduino IDE only allows
   * you to pick common rates such as 9600.
   */
  //mySerial.print(dmxvalue[j]);
  //mySerial.print(dmxvalue[0]);
  //mySerial.print(0A, HEX);
  
  //mySerial.print(dmxvalue[1], BIN);
  
  mySerial.print('H');
  // Channel 1 will need to send a id value < 255 
  // to identyfy that the incoming value is from the first channel 
  mySerial.print(",");
  
  mySerial.print(dmxvalue[2],DEC);
  mySerial.print(",");
  // Channel 2 will need to send a id value < 255 
  // to identyfy that the incoming value is from the first channel 
  //mySerial.print(257);
  mySerial.print(dmxvalue[3],DEC);
  mySerial.print(",");
  // Channel 3 will need to send a id value < 255 
  // to identyfy that the incoming value is from the first channel 
  //mySerial.print(258);
  mySerial.print(dmxvalue[4],DEC);
  mySerial.print(",");
  mySerial.println();
 
  //mySerial.print(dmxvalue[6]);
  //mySerial.print(dmxvalue[7]);
  //mySerial.print(dmxvalue[8]);
  //}
  
  return;  //go back to loop()
} //end action() loop
