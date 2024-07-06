# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, home-manager, ... }:
{
  imports =
    [
      ../shared/configuration.nix
      ../../user/user-nixos/userList.nix
      ./zfs.nix
    ];

    # x86-nixos Software
    environment.systemPackages = pkgs.callPackage ./package.nix {};

    # Use Latest Support kernelPackages for ZFS
    boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

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
            CPU_MAX_PERF_ON_BAT = 70;

           #Optional helps save long term battery health
            START_CHARGE_THRESH_BAT0 = 80; # 40 and bellow it starts to charge
            STOP_CHARGE_THRESH_BAT0 = 95; # 80 and above it stops charging

          };
    };

}
