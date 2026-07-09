#!/usr/bin/env bash

sudo apt update
sudo apt -y install qemu-utils qemu-system-modules-spice virt-manager gir1.2-spiceclientgtk-3.0
sudo usermod -aG libvirt $USER && newgrp libvirt

