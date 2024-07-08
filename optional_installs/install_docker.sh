#!/usr/bin/env bash

if [ $EUID -ne 0 ]; then
    echo "This script needs to be run with 'sudo -sE'."
    exit 1
fi

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | \
    tee /etc/apt/sources.list.d/docker.list 
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
apt update && apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
