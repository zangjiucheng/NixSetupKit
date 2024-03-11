#!/usr/bin/bash

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


installZFS
