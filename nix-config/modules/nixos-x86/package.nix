{ pkgs }:

with pkgs;
let shared-packages = import ../shared/package.nix { inherit pkgs; }; in
shared-packages ++ [
    spotify
    discord
    tlp
    lm_sensors
    iw
    xlayoutdisplay
]
