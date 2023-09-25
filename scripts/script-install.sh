#!/bin/bash

# Checking if is running in Repo Folder
if [[ "$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]')" =~ ^scripts$ ]]; then
    echo "You are running this in Schoollinux-v2 Folder."
    echo "Please use ./install.sh instead"
    exit
fi

# Installing git

echo "Installing git."
sudo apt install -y git

echo "Cloning the School Linux Project"
git clone https://github.com/blusewill/Schoollinux-v2

echo "Executing School Linux Script"

cd $HOME/Schoollinux-v2

sudo ./install.sh
