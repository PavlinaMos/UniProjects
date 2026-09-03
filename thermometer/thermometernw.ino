#define BLYNK_TEMPLATE_ID "TMPL4v2IhqZXT"
#define BLYNK_TEMPLATE_NAME "Thermometer"
#define BLYNK_AUTH_TOKEN "YOUR_BLYNK_AUTH_TOKEN"
#define BLYNK_PRINT Serial

#include <Wire.h>
#include "Waveshare_LCD1602.h"
#include <driver/adc.h>
#include <Arduino.h>

#include <WiFi.h>
#include <WiFiClient.h>
#include <BlynkSimpleEsp32.h>

char ssid[] = "SSID";
char pass[] = "PASSWORD";


Waveshare_LCD1602 lcd(16,2);  //16 characters and 2 lines of show
int r,g,b,t=0;
int flag=0;
const int lm35=32;
const int vibrationMotor=27;

const int samples = 120;  // Number of samples to average
long sum = 0;


void setup() {
    
    Serial.begin(115200);

    Blynk.begin(BLYNK_AUTH_TOKEN, ssid, pass);
    

    analogReadResolution(12);
    analogSetAttenuation(ADC_0db);
    pinMode(lm35, INPUT);
    pinMode(vibrationMotor, OUTPUT);
   // digitalWrite(vibrationMotor, HIGH); //debug

    lcd.init();

}

void loop() {


  Blynk.run();

  int analogValue = analogRead(lm35);
  Serial.println(analogValue); //debug

  for (int i = 0; i < samples; i++) {
  analogValue = analogRead(lm35);
  sum += analogValue;
  delay(10);  // Small delay between readings
}

  double averageReading = sum / samples;
  double voltage_mV = (averageReading * 1.1 * 1000) / 4095.0;
  double voltage_V = voltage_mV / 1000.0;
  double temperatureC = voltage_mV / 10.0;
  temperatureC= temperatureC * 1.3;
  sum=0;


    lcd.setCursor(0,0);
    lcd.send_string("Body Temp: ");

    lcd.setCursor(11,0);
    
    double contTemp=temperatureC;
    String tempStr = String(temperatureC);  // Converts float to String
    const char* tempCStr = tempStr.c_str(); 

    lcd.send_string(tempCStr);



    if ((contTemp>35 && contTemp<36) || (contTemp>37 && contTemp<41)){ //dangerous temp
      for(int i=0;i<3;i++){
      digitalWrite(vibrationMotor, HIGH);
      delay(400);
      digitalWrite(vibrationMotor, LOW);
      delay(400);
      } 
    }


    if (contTemp>36 && contTemp<37){            //right temp
      for(int i=0;i<2;i++){
      digitalWrite(vibrationMotor, HIGH);
      delay(250);
      digitalWrite(vibrationMotor, LOW);
      delay(250);
      }
    }


    
 
    Blynk.virtualWrite(V0, contTemp);
 
    delay(1000);

  }
