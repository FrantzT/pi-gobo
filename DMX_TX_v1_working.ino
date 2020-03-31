/* 
This is basic transmitter, which in the project is used for test reason.
It will otput DMX formated signal (but not actuall electrical DMX for this you would need to setup appropiate converter).
The DMXSimple library is required to be installed into you Arudion library, 
it is availbe for download here including additional documentation.
https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/tinkerit/DmxSimple_v3.zip */

#include <DmxSimple.h>

void setup() {
  
  /* Standard transmition rate for DMX protocol */
  
  Serial.begin(250000);
  
  /* Here we are setting up the output pin number */
  
  DmxSimple.usePin(3);

  /* Here we are setting up 3 output channels for for R,G,B values for our Pi reciever */
  
  DmxSimple.maxChannel(3);
  
}

void loop() {

    for (int i = 0; i < 255; i++){
      
      for (int j = 0; j < 255; j++){
        
        for (int k = 0; k < 255; k++){
          DmxSimple.write(1,i);
          DmxSimple.write(2,j);
          DmxSimple.write(3,k);
          delay(1); /* Small delay to slow down the ramping, make more stabile reception on reciever */
        }
      }
    }
    
    Serial.println(); // printing values to serial monitor just for test

}
