#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "You must run the script with root privileges.  Run sudo ./post-install.sh" 2>&1
    exit 1
fi

username=$(id -u -n 1000)

# Set Shell to ZSH
chsh -s /usr/bin/zsh $username

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh

# Load the dotfiles
cd /home/$username/dotfiles
./install.sh

# Cleanup
cd /home/$username
rm -rf debian-n3ph0s
reboot
