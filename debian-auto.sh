# Keymap Setup
d-i keyboard-configuration/xkb-keymap select us

# netcfg will choose an interface that has link if possible. This makes it
# skip displaying a list if there is more than one interface.
d-i netcfg/choose_interface select auto

# Hostname setup
d-i netcfg/hostname string debian-school 

# If non-free firmware is needed for the network or other hardware, you can
# configure the installer to always try to load it, without prompting. Or
# change to false to disable asking.
d-i hw-detect/load_firmware boolean true

# Skip creation of a root account (normal user account will be able to
# use sudo).
d-i passwd/root-login boolean false

# To create a normal user account.
d-i passwd/user-fullname string st
d-i passwd/username string st 
# Normal user's password, either in clear text
d-i passwd/user-password password 123
d-i passwd/user-password-again password 123

# Controls whether or not the hardware clock is set to UTC.
d-i clock-setup/utc boolean true

# Choose, if you want to scan additional installation media
# (default: false).
d-i apt-setup/cdrom/set-first boolean false

# You can choose to install non-free firmware.
d-i apt-setup/non-free-firmware boolean true

# You can choose to install non-free and contrib software.
d-i apt-setup/non-free boolean true
d-i apt-setup/contrib boolean true

# Uncomment this to add multiarch configuration for i386
d-i apt-setup/multiarch string i386

#tasksel tasksel/first multiselect standard, web-server, kde-desktop

# Or choose to not get the tasksel dialog displayed at all (and don't install
# any packages):
d-i pkgsel/run_tasksel boolean false

# Individual additional packages to install
d-i pkgsel/include string audacity audacity-data libreoffice libreoffice-gtk3 firefox-esr firefox-esr-l10n* stellarium stellarium-data kdenlive kdenlive-data extremetuxracer extremetuxracer-data ark krita* inkscape ink-generator inkscape-open-symbols inkscape-textext inkscape-tutorials fcitx5* kde-config-fcitx5 kde-plasma-desktop lsb-release flatpak sddm vim ttf-mscorefonts-installer dolphin python3.11-venv python3.11 findutils git 
# Whether to upgrade packages after debootstrap.
# Allowed values: none, safe-upgrade, full-upgrade
#d-i pkgsel/upgrade select none

# You can choose, if your system will report back on what software you have
# installed, and what software you use. The default is not to report back,
# but sending reports helps the project determine what software is most
# popular and should be included on the first CD/DVD.
popularity-contest popularity-contest/participate boolean false

# This command is run just before the install finishes, but when there is
# still a usable /target directory. You can chroot to /target and use it
# directly, or use the apt-install and in-target commands to easily install
# packages and run commands in the target system.
d-i preseed/late_command string git clone https://github.com/blusewill/SchoolLinux-v2 -C /tmp/SchoolLinux-v2
d-i preseed/late_command string bash /tmp/SchoolLinux-v2/scripts/auto-setup.sh

# Reboot the installation 
d-i debian-installer/exit/reboot boolean true


