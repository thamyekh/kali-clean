#!/usr/bin/env bash

sudo apt -y install mpv pavucontrol remmina gnome-calendar network-manager
cp ../../optional_cheats/linux.cheat $HOME/.local/share/navi/cheats
cp config $HOME/.config/i3/config
sudo cp volume-pipewire /usr/share/i3blocks
sudo cp datetime /usr/share/i3blocks
cp i3blocks.conf $HOME/.config/i3/i3blocks.conf
