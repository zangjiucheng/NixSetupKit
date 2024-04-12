# Version 0.2
# Jiucheng Zang 
# Feb. 18th 2024
# smbpasswd -a <user> ; add another user
{
  systemd.tmpfiles.rules = [
    "d /share 2777 root root -"
  ];
  services.samba-wsdd = {
    # make shares visible for Windows clients
    enable = true;
    openFirewall = true;
  };
  services.samba = {
    enable = true;
    openFirewall = true;
    securityType = "user";
    invalidUsers = [ "root" ];
    extraConfig = ''
      ## IOS Improve, VFS ##
      vfs objects = fruit streams_xattr
      fruit:metadata = stream
      fruit:model = MacSamba
      fruit:posix_rename = yes
      fruit:veto_appledouble = no
      fruit:nfs_aces = no
      fruit:wipe_intentionally_left_blank_rfork = yes
      fruit:delete_empty_adfiles = yes
      
      workgroup = WORKGROUP
      server role = standalone server
      server string = smbnix
      netbios name = smbnix
      
      max protocol = smb2
      hosts allow = 192.168.2. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      NixOS-Share = {
        path = "/share";
        browseable = "yes";
        writeable = "yes";
        public = "yes";
        "create mask" = "0644";
        "directory mask" = "2777";
        comment = "Samba Server NixOS";
      };

      # Home-Server = {
      #   path = "/mnt/primordium/data";
      #   browseable = "yes";
      #   writeable = "yes";
      #   "guest ok" = "no";
      #   public = "no";
      #   "create mask" = "0644";
      #   "directory mask" = "2777";
      #   "force user" = "dinghong";
      #   comment = "Samba Server NixOS";
      # };
    };
  };
}
