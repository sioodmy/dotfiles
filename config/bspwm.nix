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
          "urxvtd -q -o"
      ];
      settings = {
        remove_disabled_monitors = true;
        remove_unplugged_monitors = true;
        border_width = 0;
        window_gap = 28;
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
      };
    };
  };

  # Needed for bspswallow to work.
  home.file.".config/bspwm/terminals".text = "urxvt";
}
