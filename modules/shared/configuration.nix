# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, ... }:
{
  imports =
    [
      ./default.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  
  # Use grub
  boot.loader.timeout = 1;
  # boot.loader.efi = {
  #   canTouchEfiVariables = false;
  #   efiSysMountPoint = "/boot/efi";
  # };
  boot.loader.grub = {
    enable = true;
    efiInstallAsRemovable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.kernelParams = [ "mitigations=off" ];


  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Toronto";
  # services.automatic-timezoned.enable = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Font Setup
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      weather-icons
      noto-fonts
      nerdfonts
      source-han-sans
      source-han-serif
      source-code-pro
      hack-font
      jetbrains-mono
      font-awesome
      ipafont
    ];
  };


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  #i18n.defaultLocale = "zh_CN.UTF-8"; # Change to Chinese System
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-rime
      fcitx5-nord
    ];
  };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;  

  # Configure keymap in X11
  #services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound. (Depreciated from 24.11)
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Allow unfree Software
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 8080 7236 7250 443 ];
  networking.firewall.allowedUDPPorts = [ 7236 7250 443 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # system.autoUpgrade = {
  # enable = true;
  # # allowReboot = true;
  # # flake = inputs.self.outPath;
  # flags = [
  #   "--update-input"
  #   "nixpkgs"
  #   "-L" # print build logs
  # ];
  # dates = "02:00";
  # randomizedDelaySec = "45min";
  # };

}

