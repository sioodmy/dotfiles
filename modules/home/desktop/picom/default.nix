{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.desktop.picom;
in {

  options.modules.desktop.picom = { enable = mkEnableOption "picom"; };

  config = mkIf cfg.enable {
    services.picom = {
      enable = true;
      shadow = true;
      shadowOpacity = "0.2";
      extraOptions = ''
        corner-radius = 10;
        border-radius = 10;
        shadow-radius = 10;
        detect-client-opacity = true;
        transition = true;
        transition-offset = 25;
        transition-direction = "smart-x";
        transition-timing-function = "ease-out-cubic";
        transition-step = 0.028;
        inactive-opacity = 0.8;
        inactive-opacity-override = false;
        active-opacity = 1;
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
  };
}
