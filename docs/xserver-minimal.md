# Minimal Setup

This document describes the manual steps to be performed to add and configure a minimal X-Server on top of Pi-OS Lite. There is also a bash script available that performs these steps automatically.

## Prerequisites

Install Raspberry-PI OS **Lite** with the [Raspberry PI Imager](https://www.raspberrypi.com/software/)

## Create a user for running the X-Server

```bash
sudo adduser --disabled-password --gecos "" xuser
sudo usermod -aG video,input,tty xuser
```

## Configure auto login for the user

Enable auto login in `raspi-config`

## Install required packages

```bash
sudo apt install --no-install-recommends xserver-xorg x11-xserver-utils xinit xserver-xorg-video-all
```

## Configure GPU for the X-Server

```bash
sudo vi /etc/X11/xorg.conf.d/99-v3d.conf
```

```
Section "OutputClass"
  Identifier "vc4"
  MatchDriver "vc4"
  Driver "modesetting"
  Option "PrimaryGPU" "true"
EndSection
```

## Create the systemd-service for the X-Server

```bash
sudo vi /etc/systemd/system/xserver.service
```

```
[Unit]
Description=Minimal X server
After=systemd-user-sessions.service getty@tty1.service
Conflicts=getty@tty1.service

[Service]
User=xuser
WorkingDirectory=/home/xuser
PAMName=login
TTYPath=/dev/tty1
TTYReset=yes
TTYVHangup=yes
StandardInput=tty
StandardOutput=journal
StandardError=journal
Environment=DISPLAY=:0
ExecStart=/usr/bin/Xorg :0 vt1 -keeptty -nolisten tcp
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
```

## Enable the systemd-service

```bash
sudo systemctl enable xserver.service
```

## Start/Stop the systemd-service

```bash
sudo systemctl start xserver.service
```

```bash
sudo systemctl stop xserver.service
```
