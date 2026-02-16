# ESP32 Thermometer (LM35 + LCD + Blynk)

Arduino/ESP32 project that measures temperature from an LM35 sensor, displays it on a Waveshare LCD1602, sends values to Blynk, and drives a vibration motor for alerts.

## Contents

- `thermometernw.ino`: main Arduino sketch
- `Waveshare_LCD1602.h`, `Waveshare_LCD1602.cpp`: LCD drivers  
- `thermometerV3.jpg`: hardware schematics image
- `thermometer.pdf`: presentation

## Hardware

- ESP32 board
- LM35 analog temperature sensor 
- Vibration motor 
- Waveshare LCD1602 

## Software Requirements

- Arduino IDE 
- ESP32 Node MCU 32S board
- Blynk library  

## Setup

1. Open `thermometernw.ino` in Arduino IDE.
2. Set values for:
   - `BLYNK_AUTH_TOKEN`
   - `ssid`
   - `pass`
3. Install required libraries and select ESP32 board/port.
4. Build and upload.
