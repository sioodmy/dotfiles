{ config, pkgs, ... }:

{
  xsession = {
    enable = true;
    pointerCursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };
    windowManager.bspwm = {
      enable = true;
      startupPrograms = [
#        "pgrep ${pkgs.bspswallow}/bin/bspswallow || ${pkgs.bspswallow}/bin/bspswallow"
          "feh --bg-fill ~/.local/backgrounds/* --randomize"
          "xrandr --output DP-0 --mode 1920x1080 --rate 150"
#          "pgrep urxvtd || urxvtd -q -o"
          "pgrep bspswallow || bspswallow" 
      ];
      settings = {
        remove_disabled_monitors = true;
        remove_unplugged_monitors = true;
        border_width = 0;
        window_gap = 19;
      };
      monitors = {
          "focused" = [ "1" "2" "3" "4" "5" "6" "7"];
      };

      rules = {
        "Zathura" = {
          state = "tiled";
        };
        "Pavuconrtol" = {
          state = "floating";
        };
        "Pcmanfm" = {
          state = "floating";
        };
      };
    };
  };

  # Needed for bspswallow to work.
  home.file.".config/bspwm/terminals".text = "Urxvt";
  home.file.".config/bspwm/noswallow".text = "xev";
}
