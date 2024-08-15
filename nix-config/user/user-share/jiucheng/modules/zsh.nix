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
      theme = "bira";
    };

    initExtra = ''
        # >>> VIM STUFF
        bindkey '\e' vi-cmd-mode
        # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
        export KEYTIMEOUT=8
        function zle-line-init zle-keymap-select {
          RPS1="${"$"}{${"$"}{KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
          RPS2=${"$"}RPS1
          zle reset-prompt
        }
        zle -N zle-line-init
        zle -N zle-keymap-select
        # <<< VIM End <<<
        
        # >>> fzf Setup
        if [ -n "${"$"}{commands[fzf-share]}" ]; then
          source "$(fzf-share)/key-bindings.zsh"
          source "$(fzf-share)/completion.zsh"
          source ~/bin/fzf-git.sh
          export FZF_DEFAULT_OPTS='--height 60%'
          export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
          export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

          _fzf_comprun() {
            local command=$1
            shift
          
            case "$command" in
              cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
              export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
              ssh)          fzf --preview 'dig {}'                   "$@" ;;
              *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
            esac
          }
        fi
        # <<< fzf End
        
        # PATH Addon 

        export PATH="/home/jiucheng/.cargo/bin:$PATH"
    '';
  };
}
