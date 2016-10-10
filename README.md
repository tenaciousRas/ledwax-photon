#LEDWax for Particle Photon

##Cloudy LEDs

LEDWax is an IoT LED controller with support for PWM LEDs and WS28xx LED Strips.  LEDWax Photon is implemented to run on Particle Photon devices.

LEDWax for Particle Photon has been designed for use with a local cloud, which usually consists of 1+ Photons connected to an RPi running Particle Cloud Server, all connected to a home WiFi network (preferably behind a firewall).

This is the parent repository for all of the LEDWax for Particle Photon source code.  This repository includes these components:
1)  LEDWax-photon firmware.  C++ firmware that provides a REST API on the Particle Photon IoT devices.
2)  LEDWax-photon web-ui.  An AngularJS web UI that provides a user-friendly way to control LEDWax-photon hardware.
3)  LEDWax-photon emulator.  An emulator for testing the web Ui.
4)  Vagrant development environment for firmware and web UI development.  The Vagrant box comes with a headless version of ubuntu and provisions particle-cli, dfu-util, and gcc-arm-embedded, nodeJS, and Ruby, amongst other packages.  Particle-photon firmware can be built on this virtual host and pushed to a Particle Cloud Server.

## Features
1)  Cloud-based IoT.
2)  Animated LED strip control.
3)  Support for a variety of LED hardware.
4)  Modular, multi-layered architecture.
5)  Provisioned development environment.

## Getting Started
The complexity of setting up this system is approximately between non-trivial and not-very-difficult.  From a high-level, from end-to-end, these steps will take you from scratch to running IoT LED Strips w/PWM support and a Web-based UI.

1) Setup a local Particle Photon cloud on a RaspberryPi (RPi).
2) git clone this repository (See below) to another machine (or your RPi cloud server -- just be careful how much free space you have on your RPi cloud server).
3) Setup your Particle Photon IoT hardware and firmware according to [ledwax-photon-firmware documentation](https://docs.particle.io/reference/api/#get-a-variable-value "ledwax-photon-firmware documentation").
4) Deploy this web-ui to your RPi Particle Cloud Server, or another machine.  You can run it on any machine, but the WebUi is lightweight enough to run alongside the Particle Cloud Server.

### Non-Local (Particle) Cloud Server Setup
There is no reason you can't use LEDWax Photon with the Particle Cloud.  It's just that I use a local cloud, so I don't have a readily available testing platform.

### Cloning this repo
This repository contains nested git submodules.  To get all of the code you need run this:

```bash
git clone ledwax-photon
cd ledwax-photon
git submodule init
git submodule update
```

## Development Setup
Once you've cloned the 

## Firmware Configuration
This README covers setting up this codebase and Vagrant host machine.  To run a LEDWax Photon cloud you need some Particle Photon hardware loaded with the LEDWax Photon firmware.  You'll need to setup hardware and firmware according to [ledwax-photon-firmware documentation](https://docs.particle.io/reference/api/#get-a-variable-value "ledwax-photon-firmware documentation").

***
# Develop & Contribute
The "master" branch is not yet considered stable.  Stability of this repo is defined by stability of the Vagrant host and related Chef LWRPs.

### Generate documentation
TODO
This project uses Doxygen documentation generator (http://www.doxygen.org).  To view the source-code documentation you must first install DOxygen, then generate the docs.
```unix
cd ledwax-photon
doxygen ledwax_doxygen.config
```

## IDE Setup
The application is configured for two IDEs, AtomIDE and Eclipse.

Eclipse is the primary IDE (supported).  Follow the installation instructions that come with the following software packages:

1. Eclipse Mars C/C++ IDE
2. GNU ARM EABI plugin from https://gnuarmeclipse.github.io/

### Development in Eclipse IDE:
* Download development or stable branch of this repository
* (Using C/C++ (CDT) Perspective in Eclipse Mars):
* Right-click Project Explorer
  * Choose New -> Project
  * Expand C/C++
  * Choose Makefile Project with Existing Code -- click Next
  * Name the project
  * Browse to the folder contianing this project
  * Choose "Cross ARM GCC" as the compiler type (GNU ARM EABI plugin)
  * Complete the Wizard
- Once the project is imported, set the PATH to your Spark Firmware folder:
  * Right-click on the project, choose Properties (at bottom).
  * Expand C/C++
  * Choose Build Variables
  * Choose PARTICLE_FW_PATH - click the Edit button (on right)
  * Enter path to your spark-firmware directory, no trailing slash.
  * clean/build from Eclipse

NOTE:  Compilation results in Eclipse should match those from the command-line (CLI).  If something is wrong with the Eclipse build, try getting the build to run from CLI, then match the environment and command setup in Eclipse.  Eclipse should run (practically) the exact same command as a working "make" command from the CLI.  It may help to **view the Eclipse Console's "CDT Global Build Console"** when troubleshooting the "make" command(s) generated by Eclipse.

### Development in Atom IDE
Atom is the secondary (unsupported) IDE:
1. .atom-build.json is provided to assist in configuring build shell script

#### TODO
- Example circuit with example sketch config

##Credits
Thanks to Particle and Sparkfun for supporting open-source hardware and firmware and providing many resources.

## License & Authors
- Author: Free Beachler, Longevity Software LLC, ([longevitysoft@gmail.com](mailto:longevitysoft@gmail.com))
- Copyright: 2016, Free Beachler

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

