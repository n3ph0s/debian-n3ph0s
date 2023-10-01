#!/bin/bash

username=$(id -u -n 1000)

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh

# Set Shell to ZSH
chsh -s /usr/bin/zsh

# Load the dotfiles
cd /home/$username/dotfiles
./install.sh

# Cleanup
cd /home/$username
rm -rf debian-n3ph0s
reboot
