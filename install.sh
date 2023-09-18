#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
apt update
apt upgrade -y

# Install nala
apt install nala -y

# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
chown -R $username:$username /home/$username

# Installing Essential Programs 
nala install kde-plasma-desktop libreoffice libreoffice-gtk3 lsb-release firefox-esr* zettlr stellarium stellarium-data kdenlive kdenlive-data mousepad sddm vim extremetuxracer extremetuxracer-data ttf-mscorefonts-installer dolphin
# Installing Other less important Programs
nala install mixxx mixxx-data lmms lmms-common

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
cd $builddir 
nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts
wget https://github.com/justfont/open-huninn-font/releases/download/v2.0/jf-openhuninn-2.0.ttf
mv jf-openhuninn-2.0.ttf /home/$username/.fonts
mv dotfonts/fontawesome/otfs/*.otf /home/$username/.fonts/
chown $username:$username /home/$username/.fonts/*

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# SDDM Auto Login

sddm_file="/etc/sddm.conf.d/autologin.conf"

# Check if config_file is there.

if [ ! -f "$config_file" ]; then
    touch "$config_file"
fi

# Set the auto login environment

sed -i '/^\[Autologin\]/,$d' "$config_file"
echo "[Autologin]
User=$username
Session=plasma" >> "$config_file"

# Enable graphical login and change target from CLI to GUI
systemctl enable sddm
systemctl set-default graphical.target

