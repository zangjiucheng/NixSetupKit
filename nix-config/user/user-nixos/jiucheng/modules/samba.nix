{ pkgs, ... }:
{
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];
  
  fileSystems."/home/jiucheng/nas" = {
    device = "//192.168.2.99/Storage";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/home/jiucheng/smb-secrets/raspi.credit"];
  };
  
  fileSystems."/home/jiucheng/raspiShare" = {
    device = "//192.168.2.99/Public_Share";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=1000";

    in ["${automount_opts},credentials=/home/jiucheng/smb-secrets/raspi.credit"];
  };
  
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
  
  services.samba = {
  enable = true;
  openFirewall = true;
  settings = {
    global = {
      security = "user";
      "invalid users" = [ 
          "root"
      ];
      "workgroup" = "WORKGROUP";
      "server role" = "standalone server";
      "server string" = "smbnix";
      "netbios name" = "smbnix";
      
      "max protocol" = "smb2";
      "hosts allow" = "192.168.2. 127.0.0.1 localhost";
      "hosts deny" = "0.0.0.0/0";
      "guest account" = "nobody";
      "map to guest" = "bad user";
    };
  };
};
}
