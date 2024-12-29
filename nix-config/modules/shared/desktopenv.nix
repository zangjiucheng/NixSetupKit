{ pkgs, ... }:
{
  environment.pathsToLink = [ "/libexec" ];

  services.displayManager = {
    defaultSession = "none+i3";
  };
  
  services.xserver = {
    enable = true;
    
    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3lock-fancy
        i3blocks
      ];
    };
  };

  services.fractalart.enable = false; 
}
