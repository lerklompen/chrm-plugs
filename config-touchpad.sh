#!/bin/sh

CONFIG_FILE=$(echo /etc/X11/xorg.conf.d/??-touchpad-cmt.conf)
test -f $CONFIG_FILE || CONFIG_FILE="/etc/X11/xorg.conf.d/40-touchpad-cmt.conf"

# Check which type of touchpad is present.
if grep -qi synaptics /proc/bus/input/devices; then
  echo "Synaptics touchpad detected."
  TOUCHPAD="synaptics"
else
  echo "No Synaptics touchpad found, exiting."
  exit
fi

set -e

echo "Mounting the rootfs as read-write..."
mount -o remount,rw /

if [ ! -e "$CONFIG_FILE.bak" ]; then
  echo "Creating backup for $CONFIG_FILE..."
  cp $CONFIG_FILE ${CONFIG_FILE::21}XX${CONFIG_FILE:23}.bak
fi

echo "Downloading the configuration file for your touchpad..."
wget -qO $CONFIG_FILE https://raw.github.com/lerklompen/chrm-plugs/master/clickpad.xorg.conf

echo "Configuration finished. Please type 'restart ui' or reboot to make the change effective."
