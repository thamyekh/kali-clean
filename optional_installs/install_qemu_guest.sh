#!/usr/bin/env bash

# on host: 
# virt-manager > Edit > Preferences > Console > Resize guest with window: On
# Console > 'i' (second) icon > Display VNC > Type: Spice Server > Apply
# Add Hardware > Channel > Name: com.redhat.spice.0 > Device Type: Spice agent (spicevmc)
# Edit > Connection Details > default > play icon

# enable shared clipboard between host and qemu guest
echo 'deb http://ftp.nz.debian.org/debian sid main' | sudo tee -a /etc/apt/sources.list
sudo apt update && sudo apt -y install spice-vdagent
echo 'exec --no-startup-id spice-vdagent' | tee -a $HOME/.config/i3/config
echo "Done! Please reboot for clipboard share to take effect."

# on windows guests:
# download and install virtio-win-guest-tools.exe from https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/
# download and install spice-guest-tools-latest.exe from https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe
