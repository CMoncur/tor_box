# tor_box
### An all-inclusive Tor configuration for Raspberry Pi, serves as both a relay and personal Tor network
  
## Preface
tor-box is a Raspberry Pi based personal anonymizing Tor network, combined with relay functionality in order to support the volunteer-based Tor network. Upon completion of configuration, tor-box will supply a secure wireless network that one can simply connect to, and instantly anonymously browse the web, while running a relay in the background as a daemon.  Keep in mind that using an out-of-date browser while connected to tor-box is a security risk!
  
### Ready to get started?
Here is an extensive list of things you'll need before using tor-box:  
- A computer
- A fundamental understanding of Raspberry Pi configuration
- A Raspberry Pi (with power source)
- An ethernet cable
- A Raspberry Pi-compatible USB wireless adaptor
- An UP-TO-DATE browser on your personal computer
  
## Overview
We'll be breaking the setup into multiple parts. Everything in this tutorial will be done using command line, no user interface stuff.
- Setup and configuration of the Raspberry Pi
- Setting up SSH and the Avahi daemon (used to easiliy connect to the Raspberry Pi via SSH)
- Setting up the Raspberry Pi as a wireless access point
- Installing and configuring Tor
  
### Setup and Configuration
To begin, start by connecting a keyboard, mouse, monitor, and ethernet-based internet connection to your Raspberry Pi. Then, plug your Raspberry Pi into a power source.  Allow the startup sequence to commence.  You should now see a login query.  By default, the username is "pi" and the password is "raspberry"
```
login as: pi
pi@raspberrypi's password: raspberry
```
You should now see a basic command line with the following prefix:
```
pi@raspberrypi ~ $
```
You're ready to start giving your Pi some commands!  To begin, we need to configure the Raspberry Pi.  To see the configuration options, type in the following command:
```
pi@raspberrypi ~ $ raspi-config
```
When the options on the screen appear, use your arrow keys to navigate to "Advanced Options" and then navigate to "Enable/Disable SSH".  We're going to select "Enable" and hit enter.

Before exiting ```raspi-config``` be sure to change the timezone, display, and other miscellaneous settings to your choosing if you so desire.  This is optional, however.  When you're done, hit the ```esc``` key to exit configuration and go back to the command line.

###Setting up SSH and the Avahi Daemon
