{
  imports =
    [
      # Include the results of the hardware scan.
      ../user/home.nix
      ./mount.nix
      ./samba.nix
      ./zfs.nix
      ./cockpit.nix
    ];
}
