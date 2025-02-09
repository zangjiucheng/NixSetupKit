{ pkgs, ... }:

(
  with pkgs; [
      neovim
      wget
      git
      htop
      tmux
      fastfetch
      cockpit
      python3Full # Include tkinter
      yt-dlp
      ffmpeg
      samba
      gitui
      gcc
      nodejs_22
      zsh
      fzf
      bat
      pipx 
      eza
      tree
      nurl
      onefetch
      pkg-config
      openssl
      dbus
      vlc
      jq # A JSON Processor CLI
      restic
  ]
)
