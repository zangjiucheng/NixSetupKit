#!/bin/bash

DISK="/dev/sda" 
SOURCE="deb http://deb.debian.org/debian bookworm main contrib non-free-firmware"

updateAPT(){
    while IFS= read -r sour
    do
        if [[ $sour = $SOURCE ]]; then 
            echo "Add zfs resources to sources.list"
            sudo echo "deb http://deb.debian.org/debian bookworm main contrib non-free-firmware" >> /etc/apt/sources.list
            return
        fi
    done < "/etc/apt/sources.list"
}

installZFS(){
    updateAPT  
    echo "update apt list..." 
    sudo apt update
    echo "Install ZFS tool kits...."
    sudo apt install --yes debootstrap gdisk zfsutils-linux
    echo "Done!"
    echo "-----------------------------------"
}

selectDisk(){
    if [[ -z "$DISK" ]]; then 
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
	DISK="$disk"
    fi
}

installZFS
selectDisk

