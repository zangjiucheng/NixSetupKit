{ pkgs, config, ... }:
let
  home = config.home.homeDirectory;
in
{
  home.file.".config/htop/htoprc".source = pkgs.substituteAll {
    src = ../dotfiles/htoprc;
    inherit home;
  };
}
