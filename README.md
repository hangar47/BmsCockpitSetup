# BMS Cockpit Setup
Metapackage containing Raspberry PI System-Config and Documentation

## X-Server Setup

### TL/DR

```bash
curl -fsSL https://raw.githubusercontent.com/hangar47/BmsCockpitSetup/refs/heads/main/setup-xserver.sh | bash
```

### Step by Step description

[Minimal X-Server](docs/xserver-minimal.md)

The Recommended way, with a smaller footprint based on Pi-OS Lite.

[Legacy X-Server](docs/xserver-legacy.md)

The old way, based on the standard Pi-OS with a complete desktop environment.

## BMSCockpit Setup

```bash
sudo apt install bmsdisplays

curl -fsSL https://raw.githubusercontent.com/hangar47/BmsCockpitSetup/refs/heads/main/bmsdisplays.service | sudo tee /etc/systemd/system/bmsdisplays.service

sudo systemctl enable bmsdisplays.service

sudo systemctl start bmsdisplays.service
```
