{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jiucheng = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
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
      ./modules/i3.nix
      ./modules/vim.nix
      ./modules/git.nix
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
      emacs
      lxqt.qterminal
      xcompmgr
      vscode
      copyq
      flameshot
      btop
      gdb
      #todoist
      #spotify
      #discord
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      ".config/htop/htoprc".source = dotfiles/htoprc;
      ".config/qterminal.org/qterminal.ini".source = dotfiles/qterminal;
      ".background-image".source = background-image/cityGirl.jpg;
      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=36§00000
      # '';
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
      EDITOR = "vim";
    };

    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      };
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
