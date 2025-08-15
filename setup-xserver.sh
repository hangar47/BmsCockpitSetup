#!/bin/bash

set -e

sudo apt install --no-install-recommends xserver-xorg x11-xserver-utils xinit xserver-xorg-video-all

sudo adduser --disabled-password --gecos "" xuser
sudo usermod -aG video,input,tty xuser

curl -fsSL https://raw.githubusercontent.com/hangar47/BmsCockpitSetup/refs/heads/main/99-v3d.conf | sudo tee /etc/X11/xorg.conf.d/99-v3d.conf
curl -fsSL https://raw.githubusercontent.com/hangar47/BmsCockpitSetup/refs/heads/main/xserver.service | sudo tee /etc/systemd/system/xserver.service

sudo systemctl enable xserver.service

sudo systemctl start xserver.service

echo "X-Server setup complete. You can now control the X-Server with 'systemctl start|stop xserver.service'."
