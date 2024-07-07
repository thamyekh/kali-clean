#!/usr/bin/env bash

curl -sL https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | jq -r ".assets[].browser_download_url" | grep -e deb | tee /tmp/git_download
wget -i /tmp/git_download -O /tmp/obsidian.deb
sudo apt install /tmp/obsidian.deb
