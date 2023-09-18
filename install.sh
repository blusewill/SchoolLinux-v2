#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Enable contrib to have wider range of packages

sed -r -i 's/^deb(.*)$/deb\1 contrib/g' /etc/apt/sources.list

# Update packages list and update system
apt update
apt upgrade -y

# Install nala
apt install nala -y

# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
cp -R dotconfig/* /home/$username/.config/
chown -R $username:$username /home/$username

# Installing Essential Programs 
nala install kde-plasma-desktop libreoffice libreoffice-gtk3 lsb-release firefox-esr firefox-esr-l10n* flatpak stellarium stellarium-data kdenlive kdenlive-data sddm vim extremetuxracer extremetuxracer-data ttf-mscorefonts-installer dolphin python3.11-venv python3.11 ark -y

flatpak install flathub com.zettlr.Zettlr -y

# Installing Other less important Programs
nala install mixxx mixxx-data lmms lmms-common -y

# load KDE config and font install
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

mkdir /etc/sddm.conf.d

sddm_file="/etc/sddm.conf.d/autologin.conf"

# Check if sddm_file is there.

if [ ! -f "$sddm_file" ]; then
    touch "$sddm_file"
fi

# Set the auto login environment

sed -i '/^\[Autologin\]/,$d' "$sddm_file"
echo "[Autologin]
User=$username
Session=plasma" >> "$sddm_file"

# Enable graphical login and change target from CLI to GUI
systemctl enable sddm
systemctl set-default graphical.target

# Set grub timeout to 0 to make students won't click on other options

sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
update-grub

# Reboot

systemctl reboot
