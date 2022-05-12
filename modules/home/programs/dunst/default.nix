{ config, lib, pkgs, theme, ... }:
with lib;
let cfg = config.modules.programs.dunst;
in {
  options.modules.programs.dunst = { enable = mkEnableOption "dunst"; };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
      settings = with theme.colors; {
        global = {
          geometry = "350x50-12+31";
          shrink = false;
          transparency = "5";
          line_height = "4";
          word_wrap = true;
          ignore_newline = false;
          indicate_hidden = true;
          stack_duplicates = false;
          hide_duplicate_count = true;
          show_indicators = true;
          separator_height = "10";
          frame_width = "0";
          padding = "10";
          max_icon_size = "128";
          min_icon_size = "90";
          enable_recursive_icon_lookup = true;
          font = "monospace 13";
          corner_radius = "10";
          alignment = "left";
        };
        urgency_low = {
          background = "#${bg}";
          foreground = "#${fg}";
          frame_color = "#${fg}";
          timeout = "5";
        };
        urgency_normal = {
          background = "#${bg}";
          foreground = "#${fg}";
          frame_color = "#${c2}";
          timeout = "10";
        };
        urgency_critical = {
          background = "#${bg}";
          foreground = "#${fg}";
          frame_color = "#${c1}";
          timeout = "15";
        };
        notify_send = {
          appname = "notify-send";
          new_icon = "bell";
        };  
      };
    };
  };
}
