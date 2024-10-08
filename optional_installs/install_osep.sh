#!/usr/bin/env bash

sudo DEBIAN_FRONTEND=noninteractive apt -yq install apt-transport-https gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/debian stable-buster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt -yq install mono-devel msbuild samba
wget http://ftp.de.debian.org/debian/pool/main/libg/libglade2/libglade2-0_2.6.4-2+b1_amd64.deb -P /tmp
sudo DEBIAN_FRONTEND=noninteractive apt -yq install /tmp/libglade2-0_2.6.4-2+b1_amd64.deb
sudo DEBIAN_FRONTEND=noninteractive apt -yq install monodevelop

mkdir -p $HOME/osep
git clone https://github.com/thamyekh/OSEP-Code-Snippets.git $HOME/osep/OSEP-Code-Snippets
git clone https://github.com/outflanknl/EvilClippy.git $HOME/osep/EvilClippy
git clone https://github.com/SYANiDE-/SuperSharpShooter.git $HOME/osep/SuperSharpShooter

sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.old
sudo printf '[share]\n path = /home/kali/osep/\n browseable = yes\n read only = no' | sudo tee /etc/samba/smb.conf
(echo kali; echo kali) | sudo smbpasswd -a kali
sudo systemctl start smbd nmbd
chmod -R 777 $HOME/osep

# configuring proxychains for metasploit
sudo cp /etc/proxychains4.conf /etc/proxychains.conf
sudo sed -i 's/socks4\s*127.0.0.1\s*9050/socks5 127.0.0.1 1080/' /etc/proxychains.conf
sudo sed -i 's/proxy_dns/#proxy_dns/' /etc/proxychains.conf
