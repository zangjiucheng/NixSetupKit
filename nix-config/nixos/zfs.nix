{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  boot.zfs.extraPools = [ "datapool" ];
  fileSystems."/" =
    {
      device = "zpool/root";
      fsType = "zfs";
    };
  #networking.hostId = "64b1f4fc"; # generate by head -c4 /dev/urandom | od -A none -t x4
}
