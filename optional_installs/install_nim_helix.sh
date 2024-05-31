#!/usr/bin/env bash

curl https://nim-lang.org/choosenim/init.sh -sSf | sh
echo 'export PATH=$HOME/.nimble/bin:$PATH' >> $HOME/.zprofile
echo 'deb https://ppa.launchpadcontent.net/maveonair/helix-editor/ubuntu/ noble main' | sudo tee /etc/apt/sources.list.d/helix.list
sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt -yq install helix
nimble install nimlangserver
