{ pkgs, config, ... }:
let
  home = config.home.homeDirectory;
in
{
  home.file.".config/i3status/config".source = pkgs.substituteAll {
    src = ../dotfiles/i3status;
  };
}
