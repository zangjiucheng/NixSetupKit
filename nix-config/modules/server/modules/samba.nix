# Version 0.3
# Jiucheng Zang 
# Dec. 14th 2024
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
    settings = {
      global = {
        security = "user";
        "invalid users" = [ 
            "root"
        ];
        ## IOS Improve, VFS ##
        "vfs objects" = "fruit streams_xattr";
        "fruit:metadata" = "stream";
        "fruit:model" = "MacSamba";
        "fruit:posix_rename" = "yes";
        "fruit:veto_appledouble" = "no";
        "fruit:nfs_aces" = "no";
        "fruit:wipe_intentionally_left_blank_rfork" = "yes";
        "fruit:delete_empty_adfiles" = "yes";
        
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

      Public_Share = {
        comment = "Samba Share Folder";
        path = "/NAS/Share_Folder";
        writeable = "yes";
        public = "yes";
        "create mask" = 0644;
        "directory mask" = 2777;
      };

      Storage = {
        comment = "Samba Storage Folder";
        path = "/NAS/Storage";
        writeable = "yes";
      };

      NASDISK = {
        comment = "Samba Disk OverView (ReadOnly)";
        path = "/NAS";
        writeable = "no";
        browseable = "yes";
      };

      TimeMachineBackup = {
        comment = "Macos Time Machine Backup";
        path = "/NAS/TimeMachine";
        browseable = "no";
        writable = "yes";
        "fruit:time machine" = "yes";
        "fruit:zero_file_id" = "yes";
      };

      CutProject = {
        comment = "Photography Folder";
        path = "/NAS/Photography_video";
        browseable = "yes";
        writable = "yes";
      };

      BookShelf = {
        comment = "Calibre Bookshelf Server";
        path = "/NAS/calibre-web";
        writable = "yes";
        browseable = "yes";
      };

      MusicServer = {
        comment = "Music Server";
        path = "/NAS/navidrome/music";
        writable = "yes";
        browseable = "yes";
      };

      PhoneMediaBackup = {
        comment = "portable device album backup";
        path = "/NAS/PhoneMedia";
        writable = "yes";
        browseable = "yes";
      };

      AssemblyCut = {
        comment = "Storage movie edited for review";
        path = "/NAS/FilmsOutput";
        writable = "no";
        browseable = "yes";
      };

    };
  };
}
