{
  services.picom = {
    vSync = true;
    enable = true;
    backend = "glx";

    fade = true;

    shadow = true;
    
    settings = {
      use-damage = true;

      frame-opacity = 0.7;

      blur = {
        method = "gaussian";
        size = 10;
        deviation = 5.0;
      };

      detect-rounded-corners = true;
      detect-client-opacity = true;

      corner-radius = 12;
      round-borders-exclude = [ 
        "class_g = 'i3bar'"
      ];
    };
  };
}
