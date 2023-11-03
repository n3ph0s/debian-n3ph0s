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

# Install and Configure NeoVim
source /home/$username/.config/zsh/.zshrc
mkdir /home/$username/appimage && cd /home/$username/appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage 
chmod u+x nvim.appimage
sudo ln -s /home/$username/appimage/nvim.appimage /usr/local/bin/nvim.appimage
set -u
sudo update-alternatives --install /usr/bin/ex ex "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/view view "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${CUSTOM_NVIM_PATH}" 110

# Cleanup
cd /home/$username
rm -rf debian-n3ph0s
sudo reboot
