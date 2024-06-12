#!/usr/bin/env bash

# on host: 
# virt-manager > Edit > Preferences > Console > Resize guest with window: On
# Console > 'i' (second) icon > Display VNC > Type: Spice Server > Apply
# Add Hardware > Channel > Name: com.redhat.spice.0 > Device Type: Spice agent (spicevmc)

# enable shared clipboard between host and qemu guest
echo 'deb http://ftp.nz.debian.org/debian sid main' | sudo tee -a /etc/apt/sources.list
sudo apt update && sudo apt -y install spice-vdagent
# TODO: remove or add: sudo apt -y install xserver-xorg-video-xql
# enable and start service
echo 'exec --no-startup-id spice-vdagent' | tee -a $HOME/.config/i3/config
echo "Done! Please reboot for clipboard share to take effect."

