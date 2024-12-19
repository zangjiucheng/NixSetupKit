{ pkgs, ... }:
{
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];
  
  fileSystems."/NAS" = {
    device = "/dev/disk/by-label/NAS_Disk";
    fsType = "ntfs-3g"; 
    options = [ "rw" "uid=1000"];
  };
  
}
