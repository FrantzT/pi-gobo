// Example by Tom Igoe
import java.*;
import processing.serial.*;

Serial myPort;  // The serial port:
String message;
char HEADER = 'H';    // character to identify the start of a message
short LF = 10;        // ASCII linefeed
short portIndex = 0;  // select the com port, 0 is the first port
float value1 = 0;
float value2 = 0;
float value3 = 0;
PFont f;


void setup() {

  colorMode(HSB);
  size(400, 200);
  f = createFont("Arial",16,true); 
   

  printArray(Serial.list());

  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[3], 250000 );

}

void draw(){

  int x = 50;
       if(message != null){
       //print(message);
       String [] data  = message.split(",");       
          if(data[0].charAt(0) == HEADER){            
              for( int i = 1; i < data.length-1; i++){  
                if( i == 1 ){
                value1 = Integer.parseInt(data[i]);
                }
                if( i == 2 ){
                value2 = Integer.parseInt(data[i]);
                }
                if( i == 3 ){
                value3 = Integer.parseInt(data[i]); 
                }
                background(value1,value2,value3);

              }
          }
       }

}

void serialEvent(Serial myPort){
  message = myPort.readStringUntil(LF);    // read serial data

}
