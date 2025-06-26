#!/usr/bin/env bash


# (thanks https://github.com/atomantic/dotfiles/blob/main/install.sh)
source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh

bot "Hi! I'm going to install tooling and tweak your system settings. Here I go..."


curl -fsSL https://install.determinate.systems/nix | sh -s -- install

