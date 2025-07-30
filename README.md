# OpenRadFan
An ESPHome-driven smart controller for 12V PWM fans.

Classical radiators (K2/K3) typically require relatively high flow temperatures to heat up a room. Using forced convection can significally enhance their efficiency, especially at low flow temperatures. While there are a number of commercial solutions available, these did not need my needs. They are either too loud while running or switching on/off using a relays, don't properly switch at low flow temperatures, are too expensive or simply not powerful enough. Hence, I set out to build my own solution using standard 120/140mm PWM-capable PC fans. High-end fans run at low speeds (<500 RPM) are essentially inaudible and provide a definite boost to the room temperature. Being able to smartly control the fan speed and integrate them into Home Assistant - while not a must - is definitely very nice to have if you want to control fan speed based on time of day, current room temperature or room occupancy. The fans can even be used as a kind of thermostat to modulate room temperature without restricting flow to the radiators, which is especially crucial when using a heat pump that perform best with an open loop circulation and no TRVs.

Using these devices throughout our house, we can run out heat pump at flow temperatures typically reserved for good underfloor heating setups (Vaillant heat curve at 0.25 - 30°C flow temperature at 0°C, 35°C flow temperature at -10°C).

<p align="center">
  <img src="https://github.com/user-attachments/assets/cd845684-3123-46c8-9f42-816dddf3bfc0" width="400">
</p>

## Features
### Hardware
- M5Stack Atom Lite / Atom Lite S3 pluggable µC with usable Grove port for arbitrary I2C device support
- 8 fan connectors in 2x4 rows [Mini has 2 fan connectors in 2x1 rows]
- Each row can be individually PWM controlled (this is not enabled by default)
- RPM measurement for the first fan in each row [Mini only has one fan in each row]
- Global on/off switch for fans that don't support zero output at zero PWM
- Plug-in connector for two DS18B20-compatible temperature sensors [Mini only has one temperature sensor]
- Power supply: 12V barrel jack (2.1/2.5 mm), center positive
- Reverse voltage & transient overvoltage protection, 2.5 A resettable fuse
### Software
- Fully ESPHome compatible
- Controllable via Home Assistant or through any browser via stand-alone webserver
- Automatic fan curve driven speed control
- Setup & Connection to local WiFi via improv WiFi Hotspot on first boot

## Set-up instructions
**Don't connect to USB when the Atom lite is plugged into the PCB - there is no mechanism to block voltages between the included buck converter and the computer.**
1. Compile & flash ESPHome firmware on the Atom Lite using USB. Skip this step if you have a pre-flashed controller. The ESPHome directory on GitHub contains the yaml as well as factory & ota images so you can directly flash this without a local ESPHome compiler set up.
2. Connect DS18B20 to the push-in terminal block. The wire designations are marked on the PCB and are (from left to right): +3.3V, Data, GND. It's easiest to insert them all at the same time. Hold the wires in one hand in the correct order and insert them into the terminal. Then push all orange levers down at the same time and push the wires down as far as possible. The levers should almost return to the initial position and not be stuck halfway down. If you want to use more than one sensor, you need to manually edit the ESPHome yaml and include the individual IDs of the DS18B20s.
<p align="center">
  <img src="https://github.com/user-attachments/assets/6230d223-b83f-4b30-ab6f-a8feb23dc519" width="300">
</p>
4. Plug in the Atom Lite controller module and fans.
5. Lastly, plug in the barrel plug to power the device
6. On first boot, the device will present a hotspot named "openradfan-xxxxxx", with xxxxxx being the last characters of the Atom Lite's MAC address. You can connect to it in order to enter your WiFi credentials. The passwort for the hotspot is "OpenRadFan". If you get a warning that the hotspot does not provide an internet connection, click "Yes" when asked to connect anyways. Then, point your browser to http://192.168.4.1 to open the config page. Tap/click on your home WiFi and enter the password. Note down the hostname shown after "Wifi Networks:" (here "openradfan-f9465c"), this is also the hostname you can use to connect to the web interface after it has connected to your Wifi via http://openradfan-xxxxxx. It might be required to power cycle if you don't see the device appearing in your network.
<p align="center">
  <img src="https://github.com/user-attachments/assets/06640918-a550-42ce-ab53-6849ef41e133" width="200">
  <img src="https://github.com/user-attachments/assets/2d94e1f3-aa47-4eda-a9a7-c595ddca04d5" width="200">
  <img src="https://github.com/user-attachments/assets/761dc3a5-3726-49f7-b0db-54f1283777ef" width="200">
</p>
8. Home Assistant should automatically detect the device under Settings --> Devices & Services

<p align="center">
  <img src="https://github.com/user-attachments/assets/e2392dc3-ae0a-4c04-87fa-2070c89d601f" width="300">
</p>
9. You can adopt it in your local ESPHome environment. The full yaml code will be fethed from GitHub when you do so, so you can adapt the config if needed.
10. The web interface gives you full control over all aspects of the device. Over-the-air (OTA) updates can also be uploaded and flashed to the device.
<p align="center">
  <img src="https://github.com/user-attachments/assets/1e55764f-4089-4b22-83b6-d40f70c72b3f" width="200">
</p>

## Fan curve control
You can set 5 temperature points and associated fan speeds to build a temperature-dependent fan speed response. The speed between the points is interpolated linearly. The temperatures have to increase from 1 to 5; this is also enforced by internal logic. Temperatures above/below the highest/lowest setpoint keep the speed of this setpoint. Set "Auto Fan Curve Control" to on in order to use this feature.

In the below example, the fans are off below 20°C, increase between 0 and 29% speed in the range between 20 and 21°C, then increase up to 100% at 25°C. Above that, speed decreases to 28% at 30°C and the fans are off again at 35°C.

When fan speed is set to zero, the internal high-level switch also cuts all power to the fans. Some fans (e.g. Arctic PXX PWM) turn off with a zero PWM signal and wouldn't need this functionality, however many other fans cannot be turned off via PWM alone.
<p align="center">
  <img src="https://github.com/user-attachments/assets/43b18315-4771-4483-9a3d-59621cb7cb04" width="500">
</p>
