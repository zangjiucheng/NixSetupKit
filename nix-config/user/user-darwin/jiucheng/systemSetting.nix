{
  security.pam.enableSudoTouchIdAuth = true;
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      orientation = "right";
      persistent-apps = [
        "/System/Applications/Mail.app"
        "/Applications/Nix\ Apps/NetNewsWire.app"
        "/System/Applications/Calendar.app"
        "/Applications/Nix\ Apps/Visual\ Studio\ Code.app"
        "/Applications/Arc.app"
        "/Applications/Spotify.app"
        "/Applications/Nix\ Apps/Signal.app"
        "/System/Applications/Utilities/Disk Utility.app"
        "/System/Applications/Launchpad.app"
      ];
    };
    #finder.AppleShowAllExtensions = true;
    #finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "Hello World :)";
    #scrsencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };
}
