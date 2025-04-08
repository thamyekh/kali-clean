#!/usr/bin/env bash

# libfontconfig1-dev is dependency for binwalk3+ rewritten in rust

sudo apt -y install \
exiftool 
libfontconfig1-dev

cargo install binwalk
