{ pkgs, inputs, ... }:

with pkgs;
let 
  shared-packages = import ../shared/package.nix { inherit pkgs; }; 
  zenBrowser = inputs.zen-browser.packages.${pkgs.system}.default;
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
    wechat-uos
    zenBrowser

    usbutils
    udiskie
    udisks

    gcc
    glibc
    binutils
    cmake
    
    # QEMU
    quickemu
    spice-gtk
    virt-manager
] 

