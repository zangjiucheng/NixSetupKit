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
        "/Applications/Zen Browser.app"
        "/Applications/Spotify.app"
        "/Applications/Nix\ Apps/Signal.app"
        "/System/Applications/Utilities/Disk Utility.app"
        "/System/Applications/Launchpad.app"
      ];
    };
    ".GlobalPreferences"."com.apple.mouse.scaling" = 1.3;
    #finder.AppleShowAllExtensions = true;
    #finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "Hello World :)";
    #scrsencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };
}
