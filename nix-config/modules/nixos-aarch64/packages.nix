{ pkgs }:

with pkgs;

shared-packages = import ../shared/packages.nix { inherit pkgs; }; 