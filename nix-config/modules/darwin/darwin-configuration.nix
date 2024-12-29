{ config, pkgs, ... }:

{
  imports =
  [
    ../../user/user-darwin/userList.nix
  ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
    [
      tree
      htop
      pyenv
      python3Full
      fastfetch
      pandoc
      nixpkgs-fmt
      ffmpeg-full
      cmake
      wget
      ctags
      proselint
      bat
      zsh
      gitui
      graphviz
      pipx
      vscode
      neovim
      onefetch
      vscode
      ninja
      qemu
      virt-viewer
      freerdp3
      tmux
      ripgrep
      fd
      lazydocker
      ghostscript
      pinentry_mac # GPG Integration
      tree-sitter # Layvim
      
      # JIT Python compiler
      # clang_18
      # llvm_18
    ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
