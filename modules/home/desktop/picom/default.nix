{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.desktop.picom;
in {

  options.modules.desktop.picom = { enable = mkEnableOption "picom"; };

  config = mkIf cfg.enable {
    services.picom = {

      package = pkgs.picom;
      enable = true;

      shadow = true;
      shadowOffsets = [ (-12) (-12) ];

      fade = true;
      fadeDelta = 5;

      vSync = false;
      backend = "glx";

      settings = {
        fading = true;
        fade-in-step = "0.02";
        fade-out-step = "0.05";
        corner-radius = 10;
        xinerama-shadow-crop = true;

        shadow-ignore-shaped = false;

        no-fading-openclose = false;
        no-fading-destroyed-argb = true;
        active-opacity = 1.0;
        inactive-opacity = 1.0;
        frame-opacity = 1.0;

        inactive-dim = 0.0;

        glx-no-stencil = false;
        glx-copy-from-front = false;
        use-damage = true;
        detect-rounded-corners = true;
        detect-client-leader = true;
        detect-transient = true;
        unredir-if-possible = true;

        wintypes = {
          tooltip = {
            fade = false;
            full-shadow = false;
            focus = true;
            blur-background = true;
          };
          menu = { full-shadow = true; };
          popup_menu = {
            full-shadow = true;
            fade = true;
            opacity = false;
          };
          utility = { full-shadow = true; };
          toolbar = { full-shadow = true; };
          normal = { full-shadow = true; };
          notification = { full-shadow = true; };
          dialog = { full-shadow = true; };
          dock = { full-shadow = true; };
          dropdown_menu = { full-shadow = true; };
        };

        shadowOpacity = "0.4";
        shadowExclude = [
          "class_g = 'slop'"
          "class_g ?= 'peek'"
          "_NET_WM_WINDOW_TYPE@:a *= 'SPLASH'"
          "window_type = 'utility'"
          "window_type = 'dropdown_menu'"
        ];
        blur-background = true;
        blur-method = "dual_kawase";
        blur-size = 20;
        blur-deviation = 5;
        blur-background-fixed = true;
        blur-background-frame = true;
        blur-kernel = "7x7box";
        ## blur-kernel = "5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
        #
        blur-background-exclude = [
          "class_g ~= 'slop'"
          "class_g = 'spectrwm'"
          "class_g = 'GLava'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
        shadow-exclude = [ "class_g = 'slop'" ];
        focus-exclude = [
          "class_g ?= 'slop'"
          "name = 'rofi'"
          "class_g ?= 'Steam'"
          "_NET_WM_WINDOW_TYPE@:a *= 'MENU'"
          "window_type *= 'menu'"
          "window_type = 'utility'"
          "window_type = 'dropdown_menu'"
          "window_type = 'popup_menu'"
        ];
        rounded-corners-exclude = [
          "window_type = 'menu'"
          "window_type = 'popup_menu'"
          "window_type = 'utility'"
        ];
      };
    };
  };
}
