# pigobo

About

PiGobo is a proof of concept solution for Arduino based DMX signal reciever and Raspbery Pi based "Gobo" controller.

 

Install 

Transmitter

Arduino 1.8.5 and change its name to Arduino_0185 (that helps to differentiate the IDE environments) 
This IDE will be used for creating the test DMX signal source
It needs DMXSimple library to be installed

Reciever

Arduino 0023 - Legacy

This IDE will be used for the actual DMX receiver
All software package are here http://www.maxpierson.me/wp-content/uploads/2010/10/receiver_rev15.zip
It needs swap of the Hardware serial library (HardwareSerial.cpp)
Place it in /Applications/Arduino_0023.app/Contents/Resources/JAVA/hardware/arduino/cores/arduino/

! Hack:
Comment out the section bellow in HardwareSerial0.cpp to get it working with Arduino IDE 1.8.5

/* commented out to get it working with DMX code PZ082818 
		#if defined(USART_RX_vect) ISR(USART_RX_vect) 
		#elif defined(USART0_RX_vect) ISR(USART0_RX_vect) 
		#elif defined(USART_RXC_vect) ISR(USART_RXC_vect) // ATmega8 
		#else 
		#error "Don't know what the Data Received vector is called for Serial” 
		#endif 
		{ Serial._rx_complete_irq(); } 
		*/

For programming the Reciever board remove the DMX input wire from the pin 0 (RX), as if the Transmitter board is active or the input is “loaded” it will interrupt the Receiver boards communication and error the sketch upload.









