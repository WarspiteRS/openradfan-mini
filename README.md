# OpenRadFan
An ESPHome-driven smart controller for 12V PWM fans.

<img src="https://github.com/user-attachments/assets/cd845684-3123-46c8-9f42-816dddf3bfc0" width="400">

## Features
### Hardware
- M5Stack Atom Lite / Atom Lite S3 pluggable µC with usable Grove port for arbitrary I2C device support
- 8 fan connectors in 2x4 rows
- Each row can be individually PWM controlled
- RPM measurement for the first fan in each row
- Global on/off switch for fans that don't support zero output at zero PWM
- Plug-in connectors for two DS18B20-compatible temperature sensors
- Power supply: 12V barrel jack (2.1/2.5 mm), center positive
- Reverse voltage & transient overvoltage protection, 2.5 A resettable fuse
### Software
- Fully ESPHome compatible
- Controllable via Home Assistant or through any browser via stand-alone webserver
- Automatic fan curve driven speed control
- Setup & Connection to local WiFi via improv WiFi Hotspot on first boot

## Set-up instructions
**Don't connect to USB when the Atom lite is plugged into the PCB - there is no mechanism to block voltages between the included buck converter and the computer.**
1. Compile & flash ESPHome firmware on the Atom Lite using USB. Skip this step if you have a pre-flashed controller.
2. Connect DS18B20 to the push-in terminal blocks. The wire designations are marked on the PCB and are (from left to right): +3.3V, Data, GND. It's easiest to insert them all at the same time. Hold the wires in one hand in the correct order and insert them into the terminal. Then push all orange levers down at the same time and push the wires down as far as possible. The levers should almost return to the initial position and not be stuck halfway down. 
<img src="https://github.com/user-attachments/assets/6230d223-b83f-4b30-ab6f-a8feb23dc519" width="400">
3. Plug in the Atom Lite controller module and fans.
4. Lastly, plug in the barrel plug to power the device
5. On first boot, the device will present a hotspot named "openradfan-xxxxxx", with xxxxxx being the last characters of the Atom Lite's MAC address. You can connect to it in order to enter your WiFi credentials. The passwort for the hotspot is "OpenRadFan". If you get a warning that the hotspot does not provide an internet connection, click "Yes" when asked to connect anyways. Then, point your browser to http://192.168.4.1 to open the config page.
6. 
7. It might be required to power cycle the device after the credentials have been entered if the device 
