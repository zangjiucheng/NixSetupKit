{
   home-manager.users.jiucheng = { pkgs, ... }: {
     home.packages = [ pkgs.atool pkgs.httpie ];
     programs.bash.enable = true;
   
     # The state version is required and should stay at the version you
     # originally installed.
     home.stateVersion = "23.05";
   };
}
