#!/usr/bin/env bash

# acpi - needed for displaying battery in i3blocks
sudo apt -y install acpi mpv pavucontrol remmina gnome-calendar network-manager

# device dependent:
# rocm-opencl-icd (so hashcat works with amd video cards)
#

cp ../../optional_cheats/linux.cheat $HOME/.local/share/navi/cheats
cp config $HOME/.config/i3/config
sudo mkdir -p /usr/share/i3blocks
# see blockets at https://github.com/vivien/i3blocks-contrib for updated scripts
sudo cp bandwidth config datetime volume-pipewire cpu_usage disk iface memory /usr/share/i3blocks
cp i3blocks.conf $HOME/.config/i3/i3blocks.conf
sudo update-locale LANG=en_US.UTF-8
