{ pkgs, config, ... }:
let
  home = config.home.homeDirectory;
in
{
  home.file.".config/i3/config".source = pkgs.substituteAll {
    src = ../dotfiles/i3.config;
    inherit home;
    inherit (pkgs) dmenu feh;
  };
}
