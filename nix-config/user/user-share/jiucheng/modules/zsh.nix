{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake .#nixos";
      clean = "sudo nix-collect-garbage -d";
      vim = "nvim";
      neofetch = "fastfetch";
    };
  
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
  };
}
