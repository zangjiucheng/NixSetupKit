{ pkgs, ... }:
{
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];
  
  fileSystems."/NAS" = {
    device = "/dev/disk/by-label/NAS_Disk";
    options = [ "users" "nofail" ];
  };

  fileSystems."/MyBook" = {
    device = "/dev/disk/by-label/My_Book";
    options = [ "rw" "uid=1000" "nofail" ];
  };
  
}
