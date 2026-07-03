# SatScanner (DreamOS)

SatScanner is a satellite **signal finder and transponder scanner** plugin for DreamOS 2.6.
It scans a transponder, reads its services straight from the SDT, and lets you add the
channels you found to a bouquet — then zap to them. It also checks for updates on open and
can install the newest build for you.

## Install

Run this on the box (Telnet/SSH):

```sh
wget -O - https://xfayez95.github.io/satscanner/installer.sh | sh
```

The installer downloads the latest package, installs it, and restarts Enigma2 so the plugin
loads. You'll then find **SatScanner** in the Plugin Browser and the Extensions (blue button)
menu.

### Manual install

```sh
wget https://github.com/xFayez95/satscanner/releases/latest/download/satscanner-dreamos.deb
dpkg -i satscanner-dreamos.deb
```
