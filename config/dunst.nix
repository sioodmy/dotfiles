{ config, pkgs, ... }:
{
    services.dunst = {
        enable = true;
        settings = {
            global = {
                geometry = "512x15-8+31";
                frame_width = "3";
                padding = "8";
                max_icon_size = "32";
                min_icon_size = "32";
                font = "JetBrainsMonoMedium Nerd Fonti 13";
                corner_radius = "10";
            }; 
            urgency_low = {
                background = "#1E1E2E";
                foreground = "#D9E0EE";
                frame_color = "#D9E0EE";
                timeout = "5";
            };
            urgency_normal = {
                background = "#1E1E2E";
                foreground = "#D9E0EE";
                frame_color = "#ABE9B3";
                timeout = "10";
            };
            urgency_critical = {
                background = "#1E1E2E";
                foreground = "#D9E0EE";
                frame_color = "#F28FAD";
                timeout = "15";
            };
        };
    };
}
