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
        inactive-opacity-override = false;
        active-opacity = 1;
        rounded-corners-exclude = [
          "class_g = 'Dunst'",
        ];
        animations: true;

        animation-stiffness = 500
        animation-window-mass = 0.8
        animation-dampening = 25
        animation-clamping = false

        animation-for-open-window = "zoom"; #open window
        animation-for-unmap-window = "zoom"; #minimize window
# animation-for-workspace-switch-in = "slide-down"; #the windows in the workspace that is coming in
# animation-for-workspace-switch-out = "zoom"; #the windows in the workspace that are coming out
animation-for-transient-window = "slide-up"; #popup windows
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
