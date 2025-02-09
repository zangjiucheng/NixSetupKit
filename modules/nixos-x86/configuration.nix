# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, inputs, ... }:
{
  imports = [
      ../shared/configuration.nix
      ../../user/user-nixos/userList.nix
      ./zfs.nix
      ./picom.nix
  ];

  system.nixos.tags = [ "x86-user" ];

  # Avoid touchpad click to tap (clickpad) bug. For more detail see:
  # https://wiki.archlinux.org/title/Touchpad_Synaptics#Touchpad_does_not_work_after_resuming_from_hibernate/suspend
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];

  # x86-nixos Software
  environment.systemPackages = pkgs.callPackage ./package.nix { inherit inputs; };

  # Use Latest Support kernelPackages for ZFS linux_6_6
  # boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_6;

  hardware.steam-hardware.enable = true;
  
  boot.kernelModules = ["i2c-dev"];
  services.udev.extraRules = ''
        KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  services.tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 90;

          # Optional helps save long term battery health
          START_CHARGE_THRESH_BAT0 = 80; # 80 and bellow it starts to charge
          STOP_CHARGE_THRESH_BAT0 = 95; # 95 and above it stops charging

        };
  };

  environment = {
    variables = {
      LD_LIBRARY_PATH = lib.strings.concatStringsSep ":"
        [ "${pkgs.zlib}/lib"
          "${pkgs.stdenv.cc.cc.lib}/lib"
          "${pkgs.glib.out}/lib"
          "${pkgs.libGL}/lib"
          "${pkgs.fontconfig.lib}/lib"
          "${pkgs.xorg.libX11}/lib"
          "${pkgs.libxkbcommon}/lib"
          "${pkgs.dbus.lib}/lib"
          "${pkgs.freetype}/lib"
          "${pkgs.pango.out}/lib"
          # Add more paths as needed
        ];
    };
  };

  

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses; # or "gtk2" for graphical interface
    enableSSHSupport = true;
  };

  programs.light.enable = true;

  # enable usbmuxd (used for portable device connect)
  services.usbmuxd.enable = true;

  # Used for print services
  services.printing.enable = true;
    services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Automount USB drives
  services.gvfs.enable = true;
  services.udisks2.enable = true;
   
  # Bluetooth services enabled
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = { General = { ControllerMode = "bredr"; }; };
  services.blueman.enable = true;

}
