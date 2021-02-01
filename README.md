# Microcontroller-Based-Multi-Tasked-System-Development
Microcontroller Temperature Controlled System
Writing C code to implement temperature controller system on AVR ATMega128 (UNI-DS6 development board), Proteus 8 to simulate the system, which aims to keep the environment in a cool mode. To achieve that, it simultaneously recording the temperature using a potentiometer sensor. Then, the system acting accordingly by activating a PC fan using the L293D driver and simultaneously displaying the fan speed and temperature on a 4 bit LCD screen.
#Aim and Objectives
1)The system’s main aim is to create a temperature-controlled environment. In
order to achieve this system should be able to react to changes in the
environment’s temperature, and for this a temperature sensor is required. The
temperature sensor’s analogue output is going to be simulated through a
potentiometer, which is used as an adjustable voltage divider. The analogue
output signal from potentiometer will be used to emulate the output of an
analogue thermal sensor. Design the potentiometer circuit in order to get 0 to 5 V
output, and assume each 50 mV change in voltage corresponds to 1º C. Also
assume that 0 V represents 0º C
2)When the temperature exceeds 30 ºC, the buzzer should make a sound for 2
seconds as a warning signal, and a standard 3-pin PC fan should turn on at its
lowest speed. Between 30-100 º C, the fan should operate faster with increasing
temperature, and slower when the temperature decreases. The fan should be
fastest at 100 ºC. The fan should stop if the temperature falls below 30 ºC.
3)The % Fan Speed and Measured Temperature value should both be displayed
on LCD, and they should be regularly updated. Provide a chart that shows the %
Fan Speed and the measured temperature according with the corresponding
potentiometer output. Explain the logic behind your response in terms of fan
speed to your readings from the temperature sensor.
4)In addition to the LCD display, the temperature reading should also be shown on
a set of 8 LEDs on the board in thermometer code i.e. an LED is dedicated to
each 12.5 º C of the temperature range and with the increase of temperature
more LEDs will be turned on.
5)3 DIP switches should be used to enable the 3 outputs of the system i.e. switch 1
to enable temperature reading on LCD, switch 2 to enable % fan speed reading
on LCD, and switch 3 to enable thermometer code reading on LEDs. A 4th switch
should enable/disable the buzzer sound feature.
6)Simple user terminal on PC monitor should prompt the user as:
“Enter S for % fan speed and T for temperature:”
If the user enters S, the PC monitor should display the % fan speed at that
instant. If the user enters T, the temperature reading at that instant should be
displayed at the PC monitor. Then the same prompt should be displayed to ask
for the next user input. If the user enters any character other than S or T, then the
screen should display and error and ask the user to enter S or T.

![alt text](https://i.imgur.com/c9ZkAhS.png)
![alt text](https://i.imgur.com/0nQuDsb.png)
![alt text](https://i.imgur.com/uRwRpLJ.png)
![alt text](https://i.imgur.com/EiuwFLe.png)
