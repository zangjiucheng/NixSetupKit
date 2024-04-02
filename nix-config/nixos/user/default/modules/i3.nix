{ pkgs, config, ... }:
let
  home = config.home.homeDirectory;
in
{
   home.file.".config/i3/config".source = pkgs.substituteAll {
    src = ../dotfiles/i3;
    inherit home;
    inherit (pkgs) dmenu feh;
    # variables containing dashes break substituteAll :facepalm:
    i3status = pkgs.i3status-rust;
  };
}
