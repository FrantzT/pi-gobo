# PiGobo

## About

PiGobo is a proof of concept solution for Arduino based DMX signal receiver and Raspberry Pi based "Gobo" controller.

### How does it work?

Arduino TX -> DMX -> Arduino RX -> Serial -> Raspberry Pi (Processing)

Arduino TX (running with DMX_TX_v1_working.ino) sends DMX encoded values to Arduino RX (running with receiver_rev15.pde) 
which sends decoded values to Raspberry Pi ( running with DMXPi_v4.pde).

In this proof of concept 3 values are passed to Processing which will display them with function background(value1,value2,value3) using colorMode(HSB).

### Why?

This skeleton of a device can be developed into a fully functioning device able to emulate a Light Scanner and other Lighting fixtures using Raspbery's HDMI output. The core of the concept is combining Arduino's DMX functionality and ability of RPi as media generator and processor.
I was looking for this kind of simple solution, but it was not available at the time.

If you would like to get a good overview of the DMX, I recommend this short article about its implementation in unreal engine:
https://docs.unrealengine.com/en-US/WorkingWithMedia/DMX/Overview/index.html

**Note:**

To turn the Arduino into a fully functional device it requires a simple DMX signal buffer (MAX485) to be interfaced on the Arduino RX input.
Detalils of the circut: 
https://www.maxpierson.me/2010/10/09/rev15-of-the-arduino-dmx-reception-software-released/

Serial communication between Arudino RX and RPi requires logic level converter:
https://www.sparkfun.com/products/12009

## Installation

### Transmitter - Arduino TX


Arduino 1.8.5 and change its name to Arduino_0185 (that helps to differentiate the IDE environments)
This IDE will be used for creating the test DMX signal source
It requires a DMXSimple library to be installed.
Available for download here:
https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/tinkerit/DmxSimple_v3.zip

### Receiver - Arduino RX

This part is using solution for Arduino DMX receiver by Max Pierson: 
https://www.maxpierson.me/2010/10/09/rev15-of-the-arduino-dmx-reception-software-released/

After extensive research I found his design the most reliable and with all the necessary features.  

**Serial**

As the main serial port is occupied by DMX signal input, I have created another software serial port, which connects to RPi (TX only).

#define rx_Pin 9

#define tx_Pin 10


SoftwareSerial mySerial =  SoftwareSerial(rx_Pin, tx_Pin);

mySerial.begin(9600);

Which runs with a much lower bit rate (9600) then DMX (250000).

**Data frame**

ActionLoop.pde contains the actuall send block which contains data chain expected by the reciever.

Frame has a following format.

'H' ',' '(0<=255)' ',' '(0<=255)' ',' '(0<=255)' ',' '\n'


  // Start sign 'H' for the reciever 
 
  mySerial.print('H');
  

  // Channel 1 will need to send a id value 0 <= 255 
  // to identyfy that the incoming value is from the 1st channel 

  mySerial.print(",");
  mySerial.print(dmxvalue[2],DEC);

  
  // Channel 2 will need to send a id value 0 <= 255 
  // to identyfy that the incoming value is from the 2nd channel 
  
  mySerial.print(",");
  mySerial.print(dmxvalue[3],DEC);


  // Channel 3 will need to send a id value 0 <= 255 
  // to identyfy that the incoming value is from the 3rd channel 
  
  mySerial.print(",");
  mySerial.print(dmxvalue[4],DEC);
  
  // End '\n'

  mySerial.print(",");
  mySerial.println();


**Arduino 0023 - Legacy**

This IDE will be used for the actual DMX receiver
All software package are here http://www.maxpierson.me/wp-content/uploads/2010/10/receiver_rev15.zip
It needs swap of the Hardware serial library (HardwareSerial.cpp)
Place it in /Applications/Arduino_0023.app/Contents/Resources/JAVA/hardware/arduino/cores/arduino/

**Note:**
Comment out the section below in HardwareSerial0.cpp to get it working with Arduino IDE 1.8.5

/* commented out to get it working with DMX code 
        #if defined(USART_RX_vect) ISR(USART_RX_vect)
        #elif defined(USART0_RX_vect) ISR(USART0_RX_vect)
        #elif defined(USART_RXC_vect) ISR(USART_RXC_vect) // ATmega8
        #else
        #error "Don't know what the Data Received vector is called for Serial”
        #endif
        { Serial._rx_complete_irq(); }
        */

For programming the Receiver board remove the DMX input wire from the pin 0 (RX), when the Transmitter board is active or the input is “loaded” it will interrupt the Receiver boards communication and error the sketch upload.

### RPi - (Processing)

Install Processing for Raspberry Pi (tested with Rasbian) load DMXPi_v4.pde into the Processing IDE.

Since I did this development and test it, things has moved on and there is already package for Processing for RPi
https://github.com/sophacles/vim-processing


**Note:**
I have run the sketch on RPi2, which has a bit of struggle to run Processing IDE which is JAVA based.
To make my life easier I used Processing in Vim https://github.com/sophacles/vim-processing over ssh.
This significantly removes load from the RPi processor and makes developing in RPi as easy as any other system.
Applications can be compiled and run directly from the command line.

There has been particular issues with running the sketch on RPi related to security configuration.
You might need to run it with sudo.


