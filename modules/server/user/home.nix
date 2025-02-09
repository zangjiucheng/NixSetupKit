{ pkgs, ...}:
let 
  homeDir = builtins.getEnv "HOME";
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.jiucheng = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  # home-manager.backupFileExtension = "backup";

  home-manager.users.jiucheng = { config, pkgs, ... }: {
    programs.bash.enable = true;

    home.username = "jiucheng";
    home.homeDirectory = "/home/jiucheng";

    home.stateVersion = "23.11"; # Please read the comment before changing.

    imports = [
      ./modules/git.nix
    ];

    # Allow unfree Software
    nixpkgs.config.allowUnfree = true;

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
      gdb
      docker-compose
      docker
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      ".config/htop/htoprc".source = ./dotfiles/htoprc;
      ".vimrc".source = ./dotfiles/vimrc;

      "script/docker-server.sh" = {
        source = ./script/docker-server.sh;
      };      

      "script/NAS-backup.sh" = {
        source = ./script/NAS-backup.sh;
      };      

      "script/exclude-list.txt" = {
        source = ./script/exclude-list.txt;
      };      
      
      "script/navidrome" = {
        source = ./script/navidrome;
        recursive = true;
      };      

      "script/loT" = {
        source = ./script/loT;
        recursive = true;
      };      

      "script/calibre-web" = {
        source = ./script/calibre-web;
        recursive = true;
      };      

      "script/immich-app/docker-compose.yml" = {
        source = ./script/immich-app/docker-compose.yml;
      };      

      "script/immich-app/.env" = {
        source = ./script/immich-app/.env;
      };      

    };

    home.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "zsh";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
