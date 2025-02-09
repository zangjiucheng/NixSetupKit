{ pkgs, ...}:
let 
  share_folder = "../../user-share";
  homeDir = builtins.getEnv "HOME";
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  
  programs.zsh.enable = true;

  users.users.jiucheng = {
    isNormalUser = true;
    extraGroups = [ "i2c" "wheel" ];
    shell = pkgs.zsh;
  };

  imports = [
    ./modules/samba.nix
  ];

  # home-manager.backupFileExtension = "backup";

  home-manager.users.jiucheng = { config, pkgs, ... }: {
    programs.bash.enable = true;

    home.username = "jiucheng";
    home.homeDirectory = "/home/jiucheng";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.

    home.stateVersion = "23.11"; # Please read the comment before changing.

    imports = [
      ./${share_folder}/jiucheng/modules/git.nix
      ./modules/zsh.nix
      ./modules/i3.nix
      ./modules/vscode.nix
      ./x86-addon.nix
    ];

    # Allow unfree Software
    nixpkgs.config.allowUnfree = true;

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
      firefox
      lxqt.qterminal
      lxqt.qtermwidget
      xcompmgr
      vscode
      copyq
      flameshot
      btop
      gdb
      spicetify-cli
      rustup
      bitwarden-cli
      slack
      postman
      foliate


      # Latex Setup
      (pkgs.texlive.combine {
        inherit (pkgs.texlive)
          scheme-medium
          enumitem
          subfigure
          calrsfs
          changepage
          framed
          subfiles
          pgfplots
          fontsize
          xecjk
          ;
      })
 
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=36§00000
      # '';
      
      ".config/htop/htoprc".source = ./${share_folder}/jiucheng/dotfiles/htoprc.config;
      ".config/qterminal.org/qterminal.ini".source = dotfiles/qterminal.config;
      ".config/i3blocks/config".source = dotfiles/i3blocks.config;
      # ".background-image".source = ./${share_folder}/background-image/LandScaping/pexels-8moments.jpg;
      ".background-image".source = ./${share_folder}/background-image/cityGirl.jpg;
      # ".background-image".source = ./${share_folder}/background-image/littleBoy.png;
      ".face".source = ./${share_folder}/jiucheng/face.png;
      ".ssh/config".source = ./${share_folder}/jiucheng/dotfiles/ssh_config.config;
      ".config/gitui/key_bindings.ron".source = ./${share_folder}/jiucheng/dotfiles/gitui_key_bindings.ron;

      
      "bin" = {
        source = ./script;
        recursive = true;
      };      

      "Dev" = {
        source = config.lib.file.mkOutOfStoreSymlink "/datapool/Dev";
        recursive = true;
      };

      "Dev-Share" = {
        source = config.lib.file.mkOutOfStoreSymlink "/datapool/Dev-Share";
        recursive = true;
      };

      "Documents" = {
        source = config.lib.file.mkOutOfStoreSymlink "/datapool/Documents";
        recursive = true;
      };

      "Downloads" = {
        source = config.lib.file.mkOutOfStoreSymlink "/datapool/Download";
        recursive = true;
      };

      "qemu-vm" = {
        source = config.lib.file.mkOutOfStoreSymlink "/datapool/qemu-vm";
      };

    };


    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. If you don't want to manage your shell through Home
    # Manager then you have to manually source 'hm-session-vars.sh' located at
    # either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/jiucheng/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "zsh";
    };

    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];
        "x-scheme-handler/chrome" = [ "zen.desktop" ];
        "text/html" = [ "zen.desktop" ];
        "application/x-extension-htm" = [ "zen.desktop" ];
        "application/x-extension-html" = [ "zen.desktop" ];
        "application/x-extension-shtml" = [ "zen.desktop" ];
        "application/xhtml+xml" = [ "zen.desktop" ];
        "application/x-extension-xhtml" = [ "zen.desktop" ];
        "application/x-extension-xht" = [ "zen.desktop" ];
      };
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];
        "x-scheme-handler/chrome" = [ "zen.desktop" ];
        "text/html" = [ "zen.desktop" ];
        "application/x-extension-htm" = [ "zen.desktop" ];
        "application/x-extension-html" = [ "zen.desktop" ];
        "application/x-extension-shtml" = [ "zen.desktop" ];
        "application/xhtml+xml" = [ "zen.desktop" ];
        "application/x-extension-xhtml" = [ "zen.desktop" ];
        "application/x-extension-xht" = [ "zen.desktop" ];
      };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
