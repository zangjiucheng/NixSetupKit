{ config, pkgs, lib, home-manager, ... }:

let
  user = "jiucheng";
in
{
  imports = [
    ./systemSetting.nix
  ];

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      imports = [
        ./modules/vim.nix
        ./modules/git.nix
      ];

      home = {
        enableNixpkgsReleaseCheck = false;
        packages = with pkgs; [
                        tree
                        htop
                        pyenv
                        fastfetch
                        pandoc
                        nixpkgs-fmt
                        ffmpeg_5
                        cmake
                        wget
                        ctags
                        proselint
                        bat
                        zsh
                        gitui
        ];

        file = {
          ".zshrc".source = dotfiles/zshrc;
          ".ssh/config".source = dotfiles/ssh_config;
          ".config/htop/htoprc".source = dotfiles/htoprc;
        };

        stateVersion = "23.11";
      };



      # programs = {} // import ../shared/home-manager.nix { inherit config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };
}

