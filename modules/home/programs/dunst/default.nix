{ config, lib, pkgs, ... }:
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
      settings = {
        global = {
          geometry = "350x50-12+31";
          shrink = false;
          transparency = "0";
          line_height = "4";
          word_wrap = true;
          ignore_newline = false;
          indicate_hidden = true;
          stack_duplicates = false;
          hide_duplicate_count = true;
          show_indicators = true;
          separator_height = "10";
          frame_width = "2";
          frame_color = "#8aadf4";
          padding = "20";
          max_icon_size = "128";
          min_icon_size = "90";
          enable_recursive_icon_lookup = true;
          icon_path = "${pkgs.papirus-icon-theme}/usr/share/icons/Papirus-Dark/48x48/status/:${pkgs.papirus-icon-theme}/usr/share/icons/Papirus-Dark/48x48/devices/:${pkgs.papirus-icon-theme}/usr/share/icons/Papirus-Dark/48x48/apps";
          text_icon_padding = 5;
          icon_position = "left";
          font = "monospace 13";
          corner_radius = "0";
          alignment = "left";
          sticky_history = true;
          history_length = "50";
        };
        urgency_low = {
          background = "#24273a";
          foreground = "#cad3f5";
          timeout = "5";
        };
        urgency_normal = {
          background = "#24273a";
          foreground = "#cad3f5";
          timeout = "10";
        };
        urgency_critical = {
          background = "#24273a";
          foreground = "#cad3f5";
          frame_color = "#8aadf4";
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
