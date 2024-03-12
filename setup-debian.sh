#!/bin/bash

DISK="" 
SOURCE="deb http://deb.debian.org/debian bookworm main contrib non-free-firmware"
BIOS_or_UEFI=1 # 0 for BIOS, 1 for UEFI

00_updateAPT(){
    while IFS= read -r sour
    do
        if [[ $sour = $SOURCE ]]; then 
            echo "Add zfs resources to sources.list"
            sudo echo "deb http://deb.debian.org/debian bookworm main contrib non-free-firmware" >> /etc/apt/sources.list
            return
        fi
    done < "/etc/apt/sources.list"
}

01_installTempZFS(){
    updateAPT  
    echo "update apt list..." 
    sudo apt update
    echo "Install ZFS tool kits...."
    sudo apt install --yes debootstrap gdisk zfsutils-linux
    echo "Done!"
    echo "-----------------------------------"
}

02_selectDisk(){
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



03_clearDisk(){
    swapoff --all
    wipefs -a $DISK
    blkdiscard -f $DISK
    sgdisk --zap-all $DISK
}


04_zfsDiskFormat(){
    if [[ $BIOS_or_UEFI -eq 1 ]] 
    then
	sgdisk     -n2:1M:+512M   -t2:EF00 $DISK
    else
	sgdisk -a1 -n1:24K:+1000K -t1:EF02 $DISK
    fi
    sgdisk     -n3:0:+1G      -t3:BF01 $DISK

    zpool create \
    -o ashift=12 \
    -o autotrim=on \
    -o compatibility=grub2 \
    -o cachefile=/etc/zfs/zpool.cache \
    -O devices=off \
    -O acltype=posixacl -O xattr=sa \
    -O compression=lz4 \
    -O normalization=formD \
    -O relatime=on \
    -O canmount=off -O mountpoint=/boot -R /mnt \
    bpool ${DISK}-part3

    zpool create \
    -o ashift=12 \
    -o autotrim=on \
    -O acltype=posixacl -O xattr=sa -O dnodesize=auto \
    -O compression=lz4 \
    -O normalization=formD \
    -O relatime=on \
    -O canmount=off -O mountpoint=/ -R /mnt \
    rpool ${DISK}-part4
}

05_systemInstall(){
    zfs create -o canmount=off -o mountpoint=none rpool/ROOT
    zfs create -o canmount=off -o mountpoint=none bpool/BOOT

    zfs create -o canmount=noauto -o mountpoint=/ rpool/ROOT/debian
    zfs mount rpool/ROOT/debian

    zfs create -o mountpoint=/boot bpool/BOOT/debian

    zfs create                     rpool/home
    zfs create -o mountpoint=/root rpool/home/root
    chmod 700 /mnt/root
    zfs create -o canmount=off     rpool/var
    zfs create -o canmount=off     rpool/var/lib
    zfs create                     rpool/var/log
    zfs create                     rpool/var/spool

    # Optional data pool
    #zfs create -o com.sun:auto-snapshot=false rpool/var/cache
    #zfs create -o com.sun:auto-snapshot=false rpool/var/lib/nfs
    #zfs create -o com.sun:auto-snapshot=false rpool/var/tmp
    #chmod 1777 /mnt/var/tmp

    #Some functional pool may needed
    zfs create rpool/var/snap
    #zfs create rpool/var/lib/AccountsService
    #zfs create rpool/var/lib/NetworkManager
    #zfs create rpool/var/www
    #zfs create rpool/var/mail
    
    zfs create -o com.sun:auto-snapshot=false  rpool/tmp
    chmod 1777 /mnt/tmp

    mkdir /mnt/run
    mount -t tmpfs tmpfs /mnt/run
    mkdir /mnt/run/lock


    #############Install System############
    
    debootstrap bookworm /mnt
    
    #######################################
    
    mkdir /mnt/etc/zfs
    cp /etc/zfs/zpool.cache /mnt/etc/zfs/
}

06_systemConfig(){
    #Network Setup 
    hostname HOSTNAME
    hostname > /mnt/etc/hostname
    echo "127.0.1.1       HOSTNAME" >> /mnt/etc/hosts 
    cp "source.list" "/mnt/etc/apt/sources.list"
}


07_chrootSystem(){

    # Chroot System 
    mount --make-private --rbind /dev  /mnt/dev
    mount --make-private --rbind /proc /mnt/proc
    mount --make-private --rbind /sys  /mnt/sys
    chroot /mnt /usr/bin/env DISK=$DISK bash --login

    # Apt update + Local Setup 
    apt update

    apt install --yes console-setup locales

    dpkg-reconfigure locales tzdata keyboard-configuration console-setup

    # Install ZFS ins the new system 
    apt install --yes dpkg-dev linux-headers-generic linux-image-generic

    apt install --yes zfs-initramfs

    echo REMAKE_INITRD=yes > /etc/dkms/zfs.conf

    # Time Sync

    apt install systemd-timesyncd
    #apt install --yes openssh-server

    
    ## Install Grub for boot

    if [[ $BIOS_or_UEFI -eq 1 ]] 
    then
	apt install dosfstools

	mkdosfs -F 32 -s 1 -n EFI ${DISK}-part2
	mkdir /boot/efi
	echo "/dev/disk/by-uuid/$(blkid -s UUID -o value ${DISK}-part2) \
	   /boot/efi vfat defaults 0 0" >> /etc/fstab
	mount /boot/efi
	apt install --yes grub-efi-amd64 shim-signed
    else
	apt install --yes grub-pc
    fi
    
    grub-probe /boot
    update-initramfs -c -k all
    
    # Some Bug May need to be Fixed
    #vi /etc/default/grub
    # Set: GRUB_CMDLINE_LINUX="root=ZFS=rpool/ROOT/debian"
    
    #vi /etc/default/grub
    # Remove quiet from: GRUB_CMDLINE_LINUX_DEFAULT
    # Uncomment: GRUB_TERMINAL=console
    # Save and quit.
    
    update-grub

    if [[ $BIOS_or_UEFI -eq 1 ]] 
    then
	grub-install --target=x86_64-efi --efi-directory=/boot/efi \
    --bootloader-id=debian --recheck --no-floppy
    else
	grub-install $DISK
    fi


    mkdir /etc/zfs/zfs-list.cache
    touch /etc/zfs/zfs-list.cache/bpool
    touch /etc/zfs/zfs-list.cache/rpool
    zed -F &

    echo "Check if that is empty, if empty need to use Following command"
    cat /etc/zfs/zfs-list.cache/bpool
    cat /etc/zfs/zfs-list.cache/rpool
    #zfs set canmount=on     bpool/BOOT/debian
    #zfs set canmount=noauto rpool/ROOT/debian
     
    # Initial Snapshot 
    
    zfs snapshot bpool/BOOT/debian@install
    zfs snapshot rpool/ROOT/debian@install
    
    # Exit chroot System 
    
    exit

    # Umount all the workdir
    mount | grep -v zfs | tac | awk '/\/mnt/ {print $3}' | \
    xargs -i{} umount -lf {}
    zpool export -a

    reboot
}


MAIN(){
    00_updateAPT
    01_installTempZFS
    02_selectDisk
    03_clearDisk
    04_zfsDiskFormat
    05_systemInstall
    06_systemConfig
    07_chrootSystem
}


