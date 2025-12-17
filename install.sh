#!/usr/bin/env bash

sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt -yq upgrade
apt-cache --generate pkgnames | grep -Fxf requirements_utilities.txt | xargs sudo DEBIAN_FRONTEND=noninteractive apt -yq install
apt-cache --generate pkgnames | grep -Fxf requirements_toolset.txt | xargs sudo DEBIAN_FRONTEND=noninteractive apt -yq install

# personalised configurations
cp -r .config .mozilla .rustscan.toml .zprofile $HOME
mkdir -p $HOME/.local/bin
sed -i "s/#alias dir='dir --color=auto'/alias n='navi --print'/" $HOME/.zshrc
betterlockscreen -u . --fx color --color 808080

# rust tools install
cargo install rustscan navi
git clone https://github.com/thamyekh/navi-cheats ~/.local/share/navi/cheats

# nerdfonts install/reboot
mkdir -p ~/.local/share/fonts/
curl -sL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r ".assets[] | select(.name | test(\"Iosevka\")) | .browser_download_url" | grep Iosevka.zip | tee /tmp/fonts.txt
curl -sL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r ".assets[] | select(.name | test(\"RobotoMono\")) | .browser_download_url" | grep RobotoMono.zip | tee -a /tmp/fonts.txt
wget -i /tmp/fonts.txt -P /tmp
mkdir -p $HOME/.local/share/fonts/iosevka && 7z x /tmp/Iosevka.zip -o$HOME/.local/share/fonts/iosevka
mkdir -p $HOME/.local/share/fonts/robotomono && 7z x /tmp/RobotoMono.zip -o$HOME/.local/share/fonts/robotomono
fc-cache -fv
chown -R kali:kali $HOME
