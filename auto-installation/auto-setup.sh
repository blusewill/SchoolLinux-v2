#!/bin/bash

mkdir /tmp/SchoolLinux-v2
git clone https://github.com/blusewill/SchoolLinux-v2 -O /tmp/SchoolLinux-v2

username=st
builddir="/tmp/SchoolLinux-v2"

# Start to install

xargs -a $builddir/pkg-files/flatpak.txt flatpak install -y

# Making .config and Moving config files and background to Pictures

cd $builddir
mkdir -p /target/home/$username/.config
mkdir -p /target/home/$username/.fonts
cp -R dotconfig/* /target/home/$username/.config/
chown -R $username:$username /target/home/$username

# Font Install
cd $builddir 
apt install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /target/home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /target/home/$username/.fonts
wget https://github.com/justfont/open-huninn-font/releases/download/v2.0/jf-openhuninn-2.0.ttf
mv jf-openhuninn-2.0.ttf /target/home/$username/.fonts
chown $username:$username /target/home/$username/.fonts/*

# Reloading Font
fc-cache -vf

# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# SDDM Auto Login

mkdir /target/etc/sddm.conf.d

sddm_file="/target/etc/sddm.conf.d/autologin.conf"

# Check if sddm_file is there.

if [ ! -f "$sddm_file" ]; then
    touch "$sddm_file"
fi

# Set the auto login environment

sed -i '/^\[Autologin\]/,$d' "$sddm_file"
echo "[Autologin]
User=$username
Session=plasma" >> "$sddm_file"

# Set grub timeout to 0 to make students won't click on other options

sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /target/etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
update-grub
