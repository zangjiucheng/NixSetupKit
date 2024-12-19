{ pkgs, ... }:
{
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];
  
  # fileSystems."/home/jiucheng/nas" = {
  #   device = "//192.168.2.99/Storage";
  #   fsType = "cifs";
  #   options = let
  #     # this line prevents hanging on network split
  #     automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

  #   in ["${automount_opts},credentials=/home/jiucheng/smb-secrets/raspi.credit"];
  # };
  
  services.samba = {
    settings = {
      NixOS-Share = {
          path = "/share";
          browseable = "yes";
          writeable = "yes";
          public = "yes";
          "create mask" = "0644";
          "directory mask" = "2777";
          comment = "Samba Server NixOS";
      };
    };
  };

}
