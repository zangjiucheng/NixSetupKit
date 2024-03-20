{ pkgs, config, ... }:
let
  home = config.home.homeDirectory;
in
{
   home.file.".config/qterminal.org/qterminal.ini".source = pkgs.substituteAll {
    src = ../dotfiles/qterminal;
    inherit home;
  };
}
