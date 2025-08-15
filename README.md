# BMS Cockpit Setup

Metapackage containing Raspberry PI System-Config and Documentation

## X-Server Setup

### TL/DR

This script executes the necessary steps to install and start an minimal X-Server automatically.

```bash
curl -fsSL https://raw.githubusercontent.com/hangar47/BmsCockpitSetup/refs/heads/main/setup-xserver.sh | bash
```

### Step by Step description

[Minimal X-Server](docs/xserver-minimal.md)

The recommended way, with a smaller footprint based on Pi-OS Lite.

[Legacy X-Server](docs/xserver-legacy.md)

The legacy way, based on the standard Pi-OS with a complete desktop environment.

## BMSCockpit Setup

```bash
sudo apt install bmsdisplays

curl -fsSL https://raw.githubusercontent.com/hangar47/BmsCockpitSetup/refs/heads/main/bmsdisplays.service | sudo tee /etc/systemd/system/bms-displays.service

sudo systemctl enable bms-displays.service

sudo systemctl start bms-displays.service
```
