#!/bin/bash

username=$(id -u -n 1000)

# Set Shell to ZSH
chsh -s /usr/bin/zsh $username

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh

# Download and Install Packages
mkdir /home/$username/installs
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.3/obsidian_1.5.3_amd64.deb -O /home/$username/installs/obsidian.deb
sudo apt install /home/$username/installs/obsidian.deb -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Build Neovim
cd /home/$username/installs
git clone https://github.com/neovim/neovim
cd neovim && git checkout stable && CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make && cd build && sudo cpack -G DEB && sudo dpkg -i nvim-linux64.deb

# Install Flatpak Applications
clear && echo "Installing Flatpak Applications"
flatpak install --noninteractive --assumeyes org.signal.Signal
flatpak install --noninteractive --assumeyes org.qbittorrent.qBittorrent
flatpak install --noninteractive --assumeyes org.libreoffice.LibreOffice
flatpak install --noninteractive --assumeyes md.obsidian.Obsidian
flatpak install --noninteractive --assumeyes com.discordapp.Discord

# Update the TlDR repo
tldr --update

# Load the dotfiles
cd /home/$username/dotfiles
./install.sh

# Cleanup
cd /home/$username
rm -rf debian-n3ph0s
sudo rm -rf /installs
sudo reboot
