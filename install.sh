#!/usr/bin/env bash

sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt -yq upgrade
apt-cache --generate pkgnames | grep -Fxf requirements_utilities.txt | xargs sudo DEBIAN_FRONTEND=noninteractive apt -yq install
apt-cache --generate pkgnames | grep -Fxf requirements_toolset.txt | xargs sudo DEBIAN_FRONTEND=noninteractive apt -yq install

# personalised configurations
cp -r .config .local .mozilla .rustscan.toml .zprofile $HOME
mkdir -p $HOME/.local/bin
sed -i "s/#alias dir='dir --color=auto'/alias n='navi --print'/" $HOME/.zshrc
betterlockscreen -u . --fx color --color 808080

# rust tools install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
$HOME/.cargo/bin/cargo install rustscan navi

# wget tools install into /opt
sudo mkdir -p /opt/lin /opt/web /opt/win
curl -sL https://api.github.com/repos/jpillora/chisel/releases/latest | jq -r ".assets[].browser_download_url" | grep -e 386 -e amd64 | grep -v darwin | tee /tmp/git_download
curl -sL https://api.github.com/repos/nicocha30/ligolo-ng/releases/latest | jq -r ".assets[].browser_download_url" | grep -e 386 -e amd64 | grep agent | tee -a /tmp/git_download
cat /tmp/git_download | grep linux | tee /tmp/git_download_lin
cat /tmp/git_download | grep windows | tee /tmp/git_download_win
curl -sL https://api.github.com/repos/shadow1ng/fscan/releases/latest | jq -r ".assets[].browser_download_url" | grep -e fscan$ | tee -a /tmp/git_download_lin
curl -sL https://api.github.com/repos/shadow1ng/fscan/releases/latest | jq -r ".assets[].browser_download_url" | grep -e fscan.exe$ | tee -a /tmp/git_download_win
elf=$(curl -sL https://api.github.com/repos/ernw/static-toolbox/releases | jq -r ".[].tag_name" | grep nmap | head -n 1)
curl -sL https://api.github.com/repos/ernw/static-toolbox/releases/tags/$elf | jq -r ".assets[].browser_download_url" | grep _64 | grep tar | tee -a /tmp/git_download_lin
elf=$(curl -sL https://api.github.com/repos/ernw/static-toolbox/releases | jq -r ".[].tag_name" | grep socat | head -n 1)
curl -sL https://api.github.com/repos/ernw/static-toolbox/releases/tags/$elf | jq -r ".assets[].browser_download_url" | grep _64 | tee -a /tmp/git_download_lin
sudo wget -i /tmp/git_download_lin -P /opt/lin
sudo wget -i /tmp/git_download_win -P /opt/win
sudo wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh -P /opt/lin
curl -sL https://api.github.com/repos/DominicBreuker/pspy/releases/latest | jq -r ".assets[].browser_download_url" | tee /tmp/git_pspy
sudo mkdir -p /opt/lin/pspy && sudo wget -i /tmp/git_pspy -P /opt/lin/pspy
sudo git clone https://github.com/ivan-sincek/php-reverse-shell.git /opt/web/php-reverse-shell
sudo wget https://raw.githubusercontent.com/flozz/p0wny-shell/master/shell.php -P /opt/web/p0wny-shell
sudo wget https://raw.githubusercontent.com/61106960/adPEAS/main/adPEAS-Light.ps1 -P /opt/win
sudo wget https://raw.githubusercontent.com/thamyekh/OSEP-Code-Snippets/main/active_directory/Invoke-Mimikatz2.ps1 -P /opt/win
sudo wget https://gitlab.com/kalilinux/packages/windows-binaries/-/raw/kali/master/nc.exe -P /opt/win
sudo wget https://raw.githubusercontent.com/BC-SECURITY/Empire/main/empire/server/data/module_source/situational_awareness/network/powerview.ps1 -P /opt/win
sudo wget https://github.com/itm4n/PrintSpoofer/releases/download/v1.0/PrintSpoofer32.exe -P /opt/win
sudo wget https://github.com/itm4n/PrintSpoofer/releases/download/v1.0/PrintSpoofer64.exe -P /opt/win
sudo wget https://raw.githubusercontent.com/itm4n/PrivescCheck/master/PrivescCheck.ps1 -P /opt/win
sudo wget https://live.sysinternals.com/PsExec.exe -P /opt/win
sudo wget https://live.sysinternals.com/PsExec64.exe -P /opt/win
sudo wget https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_Any/Rubeus.exe -P /opt/win
sudo wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASany_ofs.exe -P /opt/win

# symlinking
sudo ln -s /opt/lin /var/www/html/lin
sudo ln -s /opt/web /var/www/html/web
sudo ln -s /opt/win /var/www/html/win

# nerdfonts install/reboot
mkdir -p ~/.local/share/fonts/
curl -sL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r ".assets[] | select(.name | test(\"Iosevka\")) | .browser_download_url" | grep Iosevka.zip | tee /tmp/fonts.txt
curl -sL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r ".assets[] | select(.name | test(\"RobotoMono\")) | .browser_download_url" | grep RobotoMono.zip | tee -a /tmp/fonts.txt
wget -i /tmp/fonts.txt -P /tmp
mkdir -p $HOME/.local/share/fonts/iosevka && 7z x /tmp/Iosevka.zip -o$HOME/.local/share/fonts/iosevka
mkdir -p $HOME/.local/share/fonts/robotomono && 7z x /tmp/RobotoMono.zip -o$HOME/.local/share/fonts/robotomono
fc-cache -fv
chown -R kali:kali $HOME
