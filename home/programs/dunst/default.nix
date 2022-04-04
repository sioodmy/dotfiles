{ config, pkgs, theme, ... }: {
  services.dunst = {
    enable = true;
    settings = with theme.colors; {
      global = {
        geometry = "512x15-19+31";
        frame_width = "2";
        padding = "8";
        max_icon_size = "128";
        min_icon_size = "64";
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
    };
  };
}
