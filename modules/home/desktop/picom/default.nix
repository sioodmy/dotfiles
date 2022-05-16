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
          shadow-radius = 10;
          detect-client-opacity = true;
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
