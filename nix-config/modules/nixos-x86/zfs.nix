{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  # boot.zfs.extraPools = ["datapool"];
  networking.hostId = "ac1ffa95"; # generate by head -c4 /dev/urandom | od -A none -t x4
}
