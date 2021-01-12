# PiGobo

About

PiGobo is a proof of concept solution for Arduino based DMX signal receiver and Raspberry Pi based "Gobo" controller.

How does it work?

Arduino TX -> Arduino RX -> Serial -> Raspberry Pi (Processing)

Arduino TX (running with DMX_TX_v1_working.ino) sends DMX encoded values to Arduino RX (running with receiver_rev15.pde) which sends decoded values to Raspberry Pi ( running with DMXPi_v4.pde).

In this proof of concept 3 values are passed to Processing which will display them with function background(value1,value2,value3) using colorMode(HSB).

Why?

This skeleton of a device can be developed into a fully functioning device able to emulate a Light Scanner and other Lighting fixtures using Raspbery's HDMI output. The core of the concept is combining Arduino's DMX functionality and ability of RPi as media generator and processor.
I was looking for this kind of simple solution, but it was not available at the time.

Note:

To turn the Arduino into a fully functional device it requires a simple DMX signal buffore to be interfaced on the Arduino RX input.


Installation

Transmitter

Arduino 1.8.5 and change its name to Arduino_0185 (that helps to differentiate the IDE environments)
This IDE will be used for creating the test DMX signal source
It needs DMXSimple library to be installed

Receiver

Arduino 0023 - Legacy

This IDE will be used for the actual DMX receiver
All software package are here http://www.maxpierson.me/wp-content/uploads/2010/10/receiver_rev15.zip
It needs swap of the Hardware serial library (HardwareSerial.cpp)
Place it in /Applications/Arduino_0023.app/Contents/Resources/JAVA/hardware/arduino/cores/arduino/

! Hack:
Comment out the section below in HardwareSerial0.cpp to get it working with Arduino IDE 1.8.5

/* commented out to get it working with DMX code PZ082818
        #if defined(USART_RX_vect) ISR(USART_RX_vect)
        #elif defined(USART0_RX_vect) ISR(USART0_RX_vect)
        #elif defined(USART_RXC_vect) ISR(USART_RXC_vect) // ATmega8
        #else
        #error "Don't know what the Data Received vector is called for Serial”
        #endif
        { Serial._rx_complete_irq(); }
        */

For programming the Receiver board remove the DMX input wire from the pin 0 (RX), as if the Transmitter board is active or the input is “loaded” it will interrupt the Receiver boards communication and error the sketch upload.

RPi

Install Processing for Raspberry Pi







