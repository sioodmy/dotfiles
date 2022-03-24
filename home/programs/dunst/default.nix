{ config, pkgs, theme, ... }: {
  services.dunst = {
    enable = true;
    settings = with theme.colors; {
      global = {
        geometry = "512x15-19+31";
        frame_width = "1";
        padding = "8";
        max_icon_size = "32";
        min_icon_size = "0";
        font = "JetBrains Mono 13";
        corner_radius = "5";
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
    };
  };
}
