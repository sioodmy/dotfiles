{ config, pkgs, theme, fetchurl, ... }:

{
  home.packages = with pkgs; [ feh bspswallow ];

  home.file.".local/backgrounds/wallpaper.png".source =
    ../../../theme/wallpaper.png;

  xsession = {
    enable = true;
    pointerCursor = {
      package = pkgs.catppuccin-cursors;
      name = "Catppuccin-Dark-Cursors";
      size = 24;
    };
    windowManager.bspwm = {
      enable = true;
      startupPrograms = [
        "feh --bg-fill ~/.local/backgrounds/wallpaper.png"
        "xrandr --output DP-0 --mode 1920x1080 --rate 150"
        "pgrep bspswallow || bspswallow"
        "xsetroot -cursor_name left_ptr"
        "eww daemon && eww open bar"
      ];
      settings = with theme.colors; {
        remove_disabled_monitors = true;
        remove_unplugged_monitors = true;
        ignore_ewmh_focus = true;
        focus_follows_pointer = true;
        border_width = 2;
        window_gap = 6;
        top_padding = 50;
        focused_border_color = "#${ac}";
        urgent_border_color = "#${c3}";
        normal_border_color = "#${bg}";
        presel_feedback_color = "#${ac}";
      };
      monitors = { "focused" = [ "1" "2" "3" "4" "5" ]; };

      rules = {
        "Zathura" = { state = "tiled"; };
        "Pavucontrol" = { state = "floating"; };
        "Pcmanfm" = { state = "floating"; };
        "pavucontrol" = { state = "floating"; };
        "transmission-gtk" = { state = "floating"; };

        "Firefox" = {
          desktop = "^2";
          follow = true;
          state = "tiled";
        };
        "csgo_linux64" = {
          desktop = "^4";
          follow = true;
        };
        "steam" = {
          desktop = "^4";
          follow = false;
          state = "floating";
        };
        "minecraft-launcher" = {
          desktop = "^4";
          follow = true;
          state = "floating";
          center = true;
        };
        "Discord" = {
          desktop = "^3";
          follow = true;
        };
        "telegram-desktop" = {
          desktop = "^3";
          follow = true;
        };
      };
    };
  };

  # Needed for bspswallow to work.
  home.file.".config/bspwm/terminals".text = "Alacritty
  kitty";
  home.file.".config/bspwm/noswallow".text = "xev";
}
