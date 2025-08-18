# Minimal Setup

This document describes the manual steps necessary to add and configure a minimal X-Server on top of Pi-OS Lite.

## Prerequisites

Install Raspberry-PI OS **Lite** with the [Raspberry PI Imager](https://www.raspberrypi.com/software/)

### Configure auto login for the user

Enable auto login in `raspi-config`

### Create a user for running the X-Server

```bash
sudo adduser --system --group --home /var/lib/bms-cockpit --shell /bin/bash bms-cockpit
sudo usermod -aG video,input,tty bms-cockpit
```

### Install required packages

```bash
sudo apt install --no-install-recommends xserver-xorg x11-xserver-utils xinit xserver-xorg-video-all
```

### Configure GPU for the X-Server

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

### Turning off screen saver

```bash
sudo vi /etc/X11/xorg.conf.d/10-monitor.conf
```

```
Section "Monitor"
    Identifier "Monitor0"
    Option "DPMS" "false"
EndSection

Section "ServerFlags"
    Option "BlankTime" "0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
EndSection
```

### Create the systemd-service for the X-Server

```bash
sudo vi /lib/systemd/system/xserver.service
```

```
[Unit]
Description=BMS-Cockpit X-Server
After=systemd-user-sessions.service getty@tty1.service
Conflicts=getty@tty1.service

[Service]
User=bms-cockpit
WorkingDirectory=/var/lib/bms-cockpit
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

### Enable the systemd-service

```bash
sudo systemctl enable xserver.service
```

### Start/Stop the systemd-service

```bash
sudo systemctl start xserver.service
```

```bash
sudo systemctl stop xserver.service
```
