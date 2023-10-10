#!/bin/bash

username=$(id -u -n 1000)

# Set Shell to ZSH
chsh -s /usr/bin/zsh $username

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh

# Install Flatpak Applications
clear && echo "Installing Flatpak Applications"
flatpak install --noninteractive --assumeyes org.signal.Signal
flatpak install --noninteractive --assumeyes org.qbittorrent.qBittorrent
flatpak install --noninteractive --assumeyes org.libreoffice.LibreOffice
flatpak install --noninteractive --assumeyes md.obsidian.Obsidian
flatpak install --noninteractive --assumeyes com.discordapp.Discord

# Load the dotfiles
cd /home/$username/dotfiles
./install.sh

# Cleanup
cd /home/$username
rm -rf debian-n3ph0s
sudo reboot
