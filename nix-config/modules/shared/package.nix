{ pkgs, ... }:

(
  with pkgs; [
      neovim
      wget
      git
      htop
      yadm
      tmux
      fastfetch
      python3Full # Include tkinter
      networkmanagerapplet
      libreoffice
      gimp
      nautilus
      samba
      gitui
      gcc
      nodejs_22
      zsh
      thefuck
      fzf
      bat
      graphviz # render dot files
      pipx 
      freerdp3
      eza
      tree
      nurl
      onefetch
      foliate # ebook reading
      pkg-config
      openssl
      avahi
      dbus
      corepack # wrappers for npm
      vlc
      cmatrix
      jq # A JSON Processor CLI
      weather
      syncthing
      gh
      myxer # Modern Volume Mixer

      # Library Required
      zlib
      glib
      libGL
      fontconfig
      xorg.libX11
      libxkbcommon
      dbus
      freetype
      pango

      # Lazyvim Required
      viu
      chafa 
      luajitPackages.luarocks 
      ueberzugpp
      fd
      ripgrep
      lazygit
      unzip
      xclip
  ]
)
