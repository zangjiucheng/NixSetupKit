{ config, pkgs, lib, home-manager, ... }:

let
  user = "jiucheng";
  share_folder = "../../user-share";
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
        #./modules/vim.nix
	#./modules/nvim.nix
        ./${share_folder}/${user}/modules/git.nix
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
                        cmake
                        wget
                        ctags
                        proselint
                        bat
                        zsh
                        gitui
			                  rogue
                        sqlite
                        gh
                        fzf
                        docker-compose
                        presenterm
                        postman
                        gimp
                        zotero
                        zoom-us
                        telegram-desktop
                        discord
                        raycast
                        slack
                        localsend
                        act

                        # For build linux kernel
                        gcc-arm-embedded
        ];

        file = {
          ".zshrc".source = dotfiles/zshrc.config;
          ".ssh/config".source =  ./${share_folder}/${user}/dotfiles/ssh_config.config;
          ".config/htop/htoprc".source = ./${share_folder}/${user}/dotfiles/htoprc.config;
          ".config/ghostty/config".source = ./${share_folder}/${user}/dotfiles/ghostty.config;
          ".config/gitui/key_bindings.ron".source = ./${share_folder}/${user}/dotfiles/gitui_key_bindings.ron;
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

