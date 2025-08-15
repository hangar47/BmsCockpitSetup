# BMS Displays

![Build Status](https://jenkins.gtidev.net/buildStatus/icon?job=BmsDisplays)

## About

Tool to replicate the F16 MFDs and other cockpit screen outputs on a Raspberry-PI.

## Installation

### Dependencies

#### Packages

    apt install libsfml-dev

#### RakNet

See `dsd` for more information on how to aquire and build

### Built

    cmake ./
    cmake --build ./
    sudo cmake --install ./

the binaries will be copied to /usr/local/bin

### Config

The config file `BmsDisplays.cfg` has to be created manually in the user home directory

#### Example

    # configure where to connect
    RTT_SERVER 192.168.178.98 44000

    # configure how to display
    #MFD_LEFT 100 400 450 450
    #MFD_RIGHT 800 400 450 450
    RWR 0 0 720 720
    #DED 0 0 400 140
    #HUD 0 0 600 600

### Autostart

Make sure that there is a user that will be logged in automatically on system start.
Copy the global _lxsession_-config to the user home if not already present.

    cp -r /etc/xdg/lxsession ~/.config/

put the following line into `~/.config/lxsession/LXDE-pi/autostart`

    @BmsDisplays

#### Example

This example disabled the standard desktop environment and opens a terminal and the display output instead.

    #@lxpanel --profile LXDE-pi
    #@pcmanfm --desktop --profile LXDE-pi
    @lxterminal
    @BmsDisplays

#### RTT Sizes

* HUD: 560, 560
* PFL: 400, 140
* DED: 400, 140
* MFD-LEFT: 450, 450
* MFD-RIGHT: 450, 450
* RWR: 240, 240
* HMS: 572, 572

### Troubleshooting

if you get an error popup "application is not responding":

    gsettings set org.gnome.mutter check-alive-timeout 0

see https://ask.fedoraproject.org/t/how-to-disable-app-is-not-responding-popup-on-gnome/24876
