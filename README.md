# BMS Cockpit Setup

Metapackage containing Raspberry PI System-Config and Documentation

## Register the BMS-Cockpit Debian Repository

```bash
curl -fsSL https://raw.githubusercontent.com/hangar47/BmsCockpitSetup/refs/heads/main/install-repo.sh | bash
```

## X-Server Setup

Installs the `bms-cockpit` meta package with the basic setup of a minimal x-server and some additional ajustments.

```bash
apt install bms-cockpit
```

### Step by Step description

The recommended way, with a smaller footprint based on Pi-OS Lite.: [Minimal X-Server](docs/xserver-minimal.md)

The legacy way, based on the standard Pi-OS with a complete desktop environment: [Legacy X-Server](docs/xserver-legacy.md)

## MFD-Display Export Setup

Installs the MFD export tool.

```bash
sudo apt install bms-cockpit-displays
```

## Instruments Export Setup

Installs the Gauges export tool.

```bash
sudo apt install bms-gauges-displays
```

These will automatically install the above mentioned meta-package with the x-server if is hasn't been already installed before.

## BMS-Cockpit Remote Management

### Dependencies

```bash
# gpiozero seems to be pre-installed on a Raspberry Pi but anyways
sudo apt install python3-pip
sudo pip install gpiozero
#or
sudo apt install python3-gpiozero

sudo apt-get install python3-psutil
```
