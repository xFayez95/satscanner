#!/bin/sh
# ---------------------------------------------------------------------------
# SatScanner one-line installer for DreamOS 2.6
#
#   wget -O - https://xfayez95.github.io/satscanner/installer.sh | sh
#
# Downloads the latest .deb from GitHub Releases and installs it with dpkg.
# ---------------------------------------------------------------------------

PLUGIN_NAME="SatScanner"
PKG_URL="https://github.com/xFayez95/satscanner/releases/latest/download/satscanner-dreamos.deb"
PKG_FILE="/tmp/satscanner-dreamos.deb"

echo "==============================================="
echo " Installing ${PLUGIN_NAME} for DreamOS"
echo "==============================================="

rm -f "$PKG_FILE"

echo "Downloading package..."
# Old DreamOS images ship an old wget/curl; try both and ignore cert/clock
# problems (many boxes have a wrong RTC and outdated CA bundle).
if command -v wget >/dev/null 2>&1; then
    wget --no-check-certificate -q -O "$PKG_FILE" "$PKG_URL" 2>/dev/null || true
fi
if [ ! -s "$PKG_FILE" ] && command -v curl >/dev/null 2>&1; then
    curl -kfsSL -o "$PKG_FILE" "$PKG_URL" || true
fi

if [ ! -s "$PKG_FILE" ]; then
    echo "ERROR: download failed."
    echo "Check network / DNS, or download the .deb manually and run: dpkg -i <file>"
    exit 1
fi

echo "Installing package..."
if ! dpkg -i "$PKG_FILE"; then
    echo "ERROR: dpkg install failed."
    rm -f "$PKG_FILE"
    exit 1
fi

rm -f "$PKG_FILE"

echo "Restarting Enigma2 to load the plugin..."
if command -v systemctl >/dev/null 2>&1; then
    systemctl restart enigma2 2>/dev/null || killall -9 enigma2 2>/dev/null || true
else
    killall -9 enigma2 2>/dev/null || true
fi

echo "${PLUGIN_NAME} installed successfully."
exit 0
