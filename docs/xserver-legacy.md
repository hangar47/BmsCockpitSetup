## Legacy Setup

This setup is based on the preinstalled desktop environment in addition to some autostart config for the BMSCockpit binaries that should be started automatically.
The actual installation of the BMSCockpit binaries is not part of this document and is represented
as `@BmsDisplays` here for the sake of descibing the integration. 

### Configure auto login for the user

Enable auto login in `raspi-config`

### Autostart

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

### Troubleshooting

if you get an error popup "application is not responding":

    gsettings set org.gnome.mutter check-alive-timeout 0

see https://ask.fedoraproject.org/t/how-to-disable-app-is-not-responding-popup-on-gnome/24876
