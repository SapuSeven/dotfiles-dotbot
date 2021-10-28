These are the dotfiles I use on my personal Arch Linux installation.

The dotfiles should work on any Arch-based system.

## Used packages
_This list is manually updated and not guaranteed to be up-to-date._

    sudo pacman -Syu xorg rxvt-unicode pcmanfm i3lock-color rofi nitrogen dunst xdotool bc numlockx brightnessctl sxhkd clipster ttf-dejavu playerctl lsof xclip mate-polkit
    yay -S xcursor-breeze lightdm-webkit-theme-sequoia-git nerd-fonts-jetbrains-mono

## Suggested packages
_These are recommendations based on personal preference._

- `evince` - PDF Viewer
- `xarchiver` - Archive Manager
- `viewnior` - Image viewer

# Installation

The following commands will place all customized dotfiles inside `~/.dotfiles` and symlink accordingly:

    git clone git@github.com:SapuSeven/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./install

# Application-specific instructions

## Mopidy

Install the following packages:

```
mopidy mopidy-mpris mopidy-iris mopidy-youtube mopidy-spotify
```

Configure PulseAudio to accept sound over TCP from localhost
by uncommenting or adding the TCP module to `/etc/pulse/default.pa`
or `~/.config/pulse/default.pa`:

```
### Network access (may be configured with paprefs, so leave this commented
### here if you plan to use paprefs)
#load-module module-esound-protocol-tcp
load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1
#load-module module-zeroconf-publish
```

Next, configure Mopidy to use this PulseAudio server in `mopidy.conf`:

```
[audio]
output = pulsesink server=127.0.0.1
```

To apply these changes, run `pulseaudio --kill` and restart Mopidy if it's running.


### Mopidy-MPRIS

If Mopidy is started as a service, you ndeed to modify `mopidy.conf` to include the following:

```
[mpris]
bus_type = system
```

The default setup will often not permit Mopidy to publish its service on the D-Bus system bus,
causing a warning similar to this in Mopidy's log:

```
MPRIS frontend setup failed (g-dbus-error-quark:
GDBus.Error:org.freedesktop.DBus.Error.AccessDenied: Connection ":1.3071"
is not allowed to own the service "org.mpris.MediaPlayer2.mopidy" due to
security policies in the configuration file (9))
```

To solve this, create the file `/usr/share/dbus-1/system.d/org.mpris.MediaPlayer2.mopidy.conf` with the following contents:

```
<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
"http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
  <!-- Allow mopidy user to publish the Mopidy-MPRIS service -->
  <policy user="mopidy">
    <allow own="org.mpris.MediaPlayer2.mopidy"/>
  </policy>

  <!-- Allow anyone to invoke methods on the Mopidy-MPRIS service -->
  <policy context="default">
    <allow send_destination="org.mpris.MediaPlayer2.mopidy"/>
    <allow receive_sender="org.mpris.MediaPlayer2.mopidy"/>
  </policy>
</busconfig>
```

Mopidy has to be restarted for the changes to take effect.


# System Configuration Templates

The files located in `templates` are intended to be used for system-specific configuration. Those vary depending on the system configuration and thus have to be installed manually.

## Shared Templates (`templates/shared/`)

These are not system-specific and may be useful for any system configuration

### `fancontrol-resume.service`

Copy to `/etc/systemd/system/` to restart fancontrol after waking up from sleep/suspend.

Then reload systemd and enable the service:

```
sudo systemctl daemon-reload
sudo systemctl enable fancontrol-resume.service
```

## Mainboard: Asus Prime X370-Pro (`templates/prime-x370-pro/`)

### `x370-pro.conf`

Copy to `/etc/modules-load.d/` to load the `it87` kernel module at boot. This is required for fan control.

### `fancontrol`

Copy to `/etc/`. Verify the correct hwmon paths or reconfigure using `pwmconfig`.

### `ASUS-PRIME-X370-PRO`

Copy to `/etc/sensors.d/`. This provides proper labels and calculations for `lm_sensors`.
