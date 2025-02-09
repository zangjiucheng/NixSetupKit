{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # IDE Improve
      vscodevim.vim
      pkief.material-icon-theme
      streetsidesoftware.code-spell-checker

      # IDE theme
      github.github-vscode-theme
      zhuangtongfa.material-theme

      # Programming Language Support
      ms-toolsai.jupyter
      james-yu.latex-workshop
      ms-python.python
    ];
  };
}
