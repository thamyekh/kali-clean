#!/usr/bin/env bash

curl https://nim-lang.org/choosenim/init.sh -sSf | sh
sed -i '2s;^;export PATH=$HOME/.nimble/bin:$PATH\n;' .zprofile
echo 'deb https://ppa.launchpadcontent.net/maveonair/helix-editor/ubuntu/ noble main' | sudo tee /etc/apt/sources.list.d/helix.list
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 355A4FA515D7C855
sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt -yq install helix
/home/kali/.nimble/bin/nimble install nimlangserver
