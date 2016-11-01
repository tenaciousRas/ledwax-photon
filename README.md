#LEDWax for Particle Photon

##LEDs On the Cloud

LEDWax is an IoT LED controller with support for PWM LEDs and WS28xx LED Strips.  LEDWax Photon is implemented to run on Particle Photon devices.

LEDWax for Particle Photon has been designed for use with a local cloud, which usually consists of 1+ Photons connected to an RPi running Particle Cloud Server, all connected to a home WiFi network (preferably behind a firewall).  LEDWax is also designed to work with the Particle public cloud.

This is the parent repository for all of the LEDWax for Particle Photon source code.  This repository includes these components:
1)  LEDWax-photon firmware.  C++ firmware that provides a REST API on the Particle Photon IoT devices.
2)  LEDWax-photon web-ui.  A HapiJS website that provides two websites:
2) 1)  A REST API (backend).
2) 2) An AngularJS Web UI (frontend) that provides a user-friendly way to control LEDWax hardware.
3)  LEDWax-photon emulator.  An emulator for testing the REST API and Web UI.
4)  Vagrant Virtual Machine (VM) for firmware and web UI development.

The Vagrant VM comes with a GUI-version of Linux Mint 17.3 and provisions particle-cli, dfu-util, gcc-arm-embedded, nodeJS, npm, and Ruby, posgresql-9.4, vim, and other packages.

Practically everything needed for LEDWax and Particle IoT development is supported with this Vagrant VM.
1)  Build LEDWax Photon firmware.  Build any Particle-photon firmware.
2)  Push LEDWax Photon firmware to a Particle Cloud Server.
3)  Build/debug/maintain the LEDWax REST API.
4)  Build/debug/maintain the LEDWax Web UI.
5)  Test the REST API and Web UI with unit and end-to-end (e2e) tests.

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
This repository contains git submodules.  To get all of the code you need run this:

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
- Vagrant Chef plugin (vagrant-omnibus)
- Librarian-Chef
- Chef CLI Tools (optional, only librarian-chef required)
- EclipseIDE or AtomIDE
- npm for Grunt

NodeJS and Ruby are installed on the VM, so you'll be using them to run tests and the web UI.  You'll probably want runtimes installed in your development environment for things to work more smoothly in your IDE.  I suggest NVM and RVM for NodeJS and Ruby version management.

This documentation assumes you have the above already configured and installed.

#### Before Starting
You'll need to install the Vagrant tools, plugins, and dependencies.  This project uses librarian-chef to manage Chef cookbooks dependencies.  After you've cloned the repo and its submodules, run librarian-chef from the project's root folder.

This command installs all the Chef cookbooks used by this project into [project-root]/cookbooks.  Beware as this will first clean/delete everything already in /cookbooks.

```bash
librarian-chef install
```
If the above command completes successfully then you should be ready to start the VM.  If it fails then you probably need to troubleshoot your librarian-chef, Vagrant, and/or NPM/NodeJS installation.  Common errors are incompatible toolchain versions, dependencies, user/group file permissions, and mis-matched/incomplete/inaccessible system symlinks and PATHing; all of which are currently beyond the scope of this document.

#### Vagrant VM
This repository comes with a vagrant development environment to save you the trouble of having to install your own development environment.

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
- Linux Mint 17.3/64 (lsoft/linux-mint-17-3-cinnamon-64 from Hashicorp Atlas Vagrant box provider)
- - Ubuntu Trusty/64 is tested and known to work (ubuntu/trusty64 from Hashicorp Atlas Vagrant box provider). **However**, only the middleware can be tested with a headless OS.  For full e2e testing a GUI is required to run Karma and ProtractorJS tests in Firefox.
- - Any Ubuntu 16.x or LinuxMint 18.x should work per the same headless/GUI note above.
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
The "master" branch is considered stable.  Stability of this repo is defined by stability of the Vagrant host and *all* related Chef LWRPs in Cheffile.  The LEDWax git submodules referenced here have their own versions and roadmaps.

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