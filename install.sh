#!/bin/bash

# Ensure that script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "You must run the script with root privileges.  Run sudo ./install.sh" 2>&1
    exit 1
fi

username=$(id -u -n 1000)

# Update package list and system
apt update && apt upgrade -y

# Install Core Programs
apt install feh kitty rofi picom thunar lxpolkit x11-xserver-utils unzip curl pulseaudio-utils pipewire pavucontrol build-essential libx11-dev libxinerama-dev apt-transport-https -y

# Install Quality of Life programs
apt install neofetch flameshot psmisc neovim lxappearance papirus-icon-theme fonts-noto-color-emoji polybar dunst conky lightdm i3 -y

# Install Brave Browser

curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list

apt update && apt install brave-browser -y

# Clone Wallpapers
git clone https://gitlab.com/dwt1/wallpapers.git /home/$username/

# Install Starship Prompt
curl -sS https://starship.rs/install.sh | sh

# Install ZSH
apt install zsh -y
chsh -s /usr/bin/zsh $username

# Enable graphical login and change target from CLI to GUI
systemctl enable lightdm
systemctl set-default graphical.target

# Dotfile configuration
git clone https://github.com/n3ph0s/dotfiles.git /home/$username/
cd /home/$username/dotfiles
bash install.sh
cd /home/$username

# Cleanup 
rm -rf /home/$username/debian-n3ph0s
reboot
