{ pkgs, config, ... }:

{
  services.picom = {
    enable = true;
    shadow = true;
    shadowOpacity = "0.2";
    extraOptions = ''
        shadow-radius = 10;
        corner-radius = 10;
        round-borders = 10;
        rounded-corners-exclude = [
      #   "window_type = 'dock'",
         "class_g = 'eww-bar'"
      ];
    '';
    fadeExclude = [
      # "class_g = 'Rofi'"
      "class_g = 'slop'"
    ];
    shadowExclude = [ "class_g = 'slop'" ];
    backend = "glx";
    fade = true;
    fadeDelta = 4;
    fadeSteps = [ "0.03" "0.03" ];
    vSync = true;
  };
}
