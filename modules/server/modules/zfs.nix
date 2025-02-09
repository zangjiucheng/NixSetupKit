{
  boot.zfs.forceImportRoot = false;
  boot.zfs.extraPools = ["datapool"];

  services.zfs.autoSnapshot.enable =  true;

  networking.hostId = "ac1ffa95"; # generate by head -c4 /dev/urandom | od -A none -t x4
}
