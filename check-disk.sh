#!/bin/bash
set -e

echo "WARNING!!! The following script will install Debian on the following hard drive, wiping anything else on it."
echo "This includes FILES as well as any existing OPERATING SYSTEMS."
echo "Only use if you know exactly what you are doing!!!"
echo ""

# get the list of all block devices under /dev except mounted drives
devices=$(lsblk -rno NAME,SIZE,MOUNTPOINT | awk '$3 == "" {print "/dev/"$1,$2}')

# display the available drives
echo "Available drives:"
echo "$devices"

# prompt the user to select a drive
read -p "Enter the device name for the drive you want to install on (e.g. /dev/sda): " disk

# if the user input is invalid, set the default to /dev/sda
while [[ ! $devices =~ (^|[[:space:]])"$disk"($|[[:space:]]) ]]
do  
    echo "Invalid input. Input aagin!"
    read -p "Enter the device name for the drive you want to install on (e.g. /dev/sda): " disk
done

echo "You selected $disk."
echo ""