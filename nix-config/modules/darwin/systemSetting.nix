{
    security.pam.enableSudoTouchIdAuth = true;
    system.defaults = {
	dock = {
	    autohide = true;
	    mru-spaces = false;
	    orientation = "right";
	    persistent-apps = [
		"/System/Applications/Mail.app"
		"/System/Applications/Calendar.app"
		"/Applications/Visual Studio Code.app"
		"/nix/store/6194a3v146s47gnqczk4azk6mfkwhls6-emacs-29.2/Applications/Emacs.app"
		"/Applications/Signal.app"
  		"/System/Applications/Utilities/Disk Utility.app"
	    ];
	};
	#finder.AppleShowAllExtensions = true;
	#finder.FXPreferredViewStyle = "clmv";
	loginwindow.LoginwindowText = "Hello World :)";
	#scrsencapture.location = "~/Pictures/screenshots";
	screensaver.askForPasswordDelay = 10;
    };
}
