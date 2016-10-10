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

### Requirements
- Ubuntu 14+; Mac OS X 10.8+(?)
- Windows not supported by all site-cookbooks, but it wouldn't take too long to add Windows support.
- Vagrant 12.x
- VirtualBox 5.x
- EclipseIDE or AtomIDE
- npm for Grunt

NodeJS and Ruby are installedon the VM, so you'll be using them to run tests and the web UI.  However, you'll probably want runtimes installed in your development environment for things to work more smoothly in your IDE.  I suggest NVM and RVM for NodeJS and Ruby version management.

This documentation assumes you have the above already configured and installed.

To start the VM:
```bash
vagrant up
```

It can take up to 45-60 minutes to finish this command the first time.  The reason for this is Vagrant has to download the VM image, and then provision everything on the machine.  Things will run faster after the first time you bring the VM up.

Connect to VM:
```bash
vagrant ssh
```

To stop the VM:
```bash
vagrant suspend
```

Stopping the VM frees resources on the host machine but leaves the VM provisioned.  You can also destroy the VM and restart it from scratch, as well re-provision it.  See the Vagrant website for more information on Vagrant usage.

### Vagrant
The vagrant box provided has the following specs:
- Ubuntu Trusty/64 (ubuntu/trusty64 from Hashicorp Atlas Vagrant box provider)
- Chef
- Chef-Librarian for Chef dependencies.
- provisioned with
-- nodeJS 4.x LTS
-- Ruby 2.x
-- build-essential
-- git
-- gcc-arm-embedded
-- particle-cli
-- dfu-util
-- VM shares
-- /home/vagrant/vagrant-host points at src/ of this repository
-- default /vagrant share on VM is disabled

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
Copyright (c) 2015-2016, Free Beachler, Longevity Software LLC.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Free Beachler, Longevity Software LLC, nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Free Beachler BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.