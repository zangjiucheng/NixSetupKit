{ lib, pkgs, config, ... }:
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
  #xsession.windowManager.i3 = {
  #  enable = true;
  #  config = {
  #    bars = [
  #      {
  #        position = "top";
  #        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
  #      }
  #    ];
  #  };
  #};

  #programs.i3status-rust = {
  #  enable = true;
  #  bars = {
  #    top = {
  #      blocks = [
  #       {
  #         block = "time";
  #         interval = 60;
  #         format = "%a %d/%m %k:%M %p";
  #       }
  #     ];
  #    };
  #  };
  #};
}
