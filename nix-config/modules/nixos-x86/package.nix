{ pkgs, ... }:

with pkgs;
let 
  shared-packages = import ../shared/package.nix { inherit pkgs; }; 
in
shared-packages ++ [
    spotify
    discord
    tlp
    lm_sensors
    iw
    xlayoutdisplay
    gnumake
    libgcc
    chromium
    gnome-network-displays
    quickemu
    zfs
    brightnessctl
    ddcutil
    i2c-tools
    teams-for-linux
    zoom-us
    ifuse
    libimobiledevice
    libsecret
    thunderbird

    usbutils
    udiskie
    udisks
] 
