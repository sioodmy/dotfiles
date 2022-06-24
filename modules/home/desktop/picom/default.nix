{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.desktop.picom;
in {

  options.modules.desktop.picom = { enable = mkEnableOption "picom"; };

  config = mkIf cfg.enable {
    services.picom = {

      package = pkgs.picom.overrideAttrs (o: {
        src = pkgs.fetchFromGitHub {
          repo = "picom";
          owner = "ibhagwan";
          rev = "c4107bb6cc17773fdc6c48bb2e475ef957513c7a";
          sha256 = "1hVFBGo4Ieke2T9PqMur1w4D0bz/L3FAvfujY9Zergw=";
        };
      });
      enable = true;
      shadow = false;
      shadowOpacity = "0.2";
      extraOptions = ''
      daemon = true;
      use-damage = false;                         # Fixes flickering and visual bugs with borders
      resize-damage = 1
      refresh-rate = 0;
      corner-radius = 10;                          # Corners
      round-borders = 10;
      fade-out-step = 1;                          # Will fix random border dots from not disappearing
      detect-rounded-corners = true;              # Below should fix multiple issues
      detect-client-opacity = false;
      detect-transient = true
      detect-client-leader = false
      mark-wmwim-focused = true;
      mark-ovredir-focues = true;
      unredir-if-possible = true;
      glx-no-stencil = true;
      glx-no-rebind-pixmap = true;
      wintypes:
      {
        popup_menu = { shadow = false; };
        dropdown_menu = { shadow = false; };
        dnd = { shadow = false; };
        dock = { shadow = false; };
        tooltip = { fade = true; shadow = true; opacity = 1.0; focus = true; };
        notification = { fade = false; };
      };
      '';

      fadeExclude = [
        # "class_g = 'Rofi'"
        "class_g = 'slop'"
      ];
      shadowExclude = [ "class_g = 'slop'" ];
      backend = "glx";
      vSync = true;
    };
  };
}
