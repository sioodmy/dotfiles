{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.desktop.picom;
in {

  options.modules.desktop.picom = { enable = mkEnableOption "picom"; };

  config = mkIf cfg.enable {
    services.picom = {

      package = pkgs.picom-dccsillag;
      enable = true;

      shadow = true;
      shadowOffsets = [ (-12) (-12) ];
      shadowOpacity = "0.4";
      shadowExclude = [
        "class_g = 'slop'"
        "class_g ?= 'peek'"
        "_NET_WM_WINDOW_TYPE@:a *= 'SPLASH'"
        "window_type = 'utility'"
        "window_type = 'dropdown_menu'"
      ];

      fade = true;
      fadeDelta = 5;
      fadeSteps = [ "0.03" "0.03" ];

      vSync = true;
      backend = "glx";

      extraOptions = ''
      corner-radius = 10;

      xinerama-shadow-crop = true;
      shadow-ignore-shaped = false;

      no-fading-openclose = false
      no-fading-destroyed-argb = true

      fade-exclude = [
        "class_g = 'slop'"   # maim
      ]

      active-opacity = 1.0;
      inactive-opacity = 1.0;
      frame-opacity = 1.0;
      inactive-dim = 0.0;

      animations: true;
      animation-stiffness = 300
      animation-window-mass = 0.7
      animation-dampening = 20
      animation-clamping = false
      animation-for-open-window = "zoom"; #open window
      animation-for-unmap-window = "zoom"; #minimize window
      animation-for-workspace-switch-in = "slide-down"; #the windows in the workspace that is coming in
      animation-for-workspace-switch-out = "slide-up"; #the windows in the workspace that are coming out
      animation-for-transient-window = "slide-up"; #popup windows
      opacity-rule = [];

      focus-exclude = [
            #"class_g ?= 'rofi'"
            #'_NET_WM_NAME@:s = "rofi"'
            "class_g ?= 'slop'",
            "name = 'rofi'",
            "class_g ?= 'Steam'",
            "_NET_WM_WINDOW_TYPE@:a *= 'MENU'",
            "window_type *= 'menu'",
            "window_type = 'utility'",
            "window_type = 'dropdown_menu'",
            "window_type = 'popup_menu'"
          ];
          rounded-corners-exclude = [
            "window_type = 'menu'",
            "window_type = 'popup_menu'",
            "window_type = 'utility'",
            "class_g = 'awesome'",
          ];

          glx-no-stencil = false;
          glx-copy-from-front = false;
          use-damage = true;
          detect-rounded-corners = true;
          detect-client-leader = true;
          detect-transient = true;
          unredir-if-possible = true;

          wintypes:
          {
            tooltip = { fade = true; full-shadow = true; focus = true; blur-background = false;};
            menu = { full-shadow = true;};
            popup_menu =  { full-shadow = true;};
            utility =  {full-shadow = true;};
            toolbar = {full-shadow = true;};
            normal = {full-shadow = true;};
            notification = {full-shadow = true;};
            dialog = {full-shadow = true};
            dock = {full-shadow = true;};
            dropdown_menu = { full-shadow = true;};
          };
          '';

        };
      };
    }
