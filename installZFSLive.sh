#!/usr/bin/sh
#
echo "Add zfs resources to sources.list"
sudo echo "deb http://deb.debian.org/debian bookworm main contrib non-free-firmware" >> /etc/apt/sources.list
echo "update apt list..." 
sudo apt update
echo "Install ZFS tool kits...."
sudo apt install --yes debootstrap gdisk zfsutils-linux

