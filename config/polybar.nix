{ pkgs, config, ...}:

{
    services.polybar = {
        enable = true;
        package = pkgs.polybar.override {
            pulseSupport = true;
        };

        script = ''
          polybar top &
        '';
        config = {
            "bar/top" = {
                monitor = "\${env:MONITOR}";
                width = "98%";
                offset-x = "1%";
                offset-y = "1%";
                height = 30;
                radius = 0;
                modules-left = "date";
                modules-center = "bspwm";
                modules-right = "volume memory cpu";
                font-0 = "JetBrainsMono Nerd Font:style=Medium:pixelsize=14;3";
                font-1 = "unifont:fontformat=truetype:size=14:antialias=false;3";
                background = "#1E1E2E";
            };

            "module/date" = {
                type = "internal/date";
                internal = 5;
                date = "%d.%m.%y";
                time = "%H:%M";
                label = "%{F#96CDFB}%{F-} %time%  %{F#89DCEB}%{F-} %date%"; 
                label-margin = 2;
            };

            "module/bspwm" = {
                type = "internal/bspwm";
                label-focused = "";
                label-focused-padding = "1.5";
                label-foreground = "#D9E0EE";

                label-occupied = "";
                label-occupied-padding = "1.5";

                label-empty = "";
                label-empty-padding = "1.5";

                label-urgent = "";
                label-urgent-padding = "1.5";
            };

            "module/cpu" = {
                type = "internal/cpu";
                interval = 2;
                label = "%{F#ABE9B3}%{F-} %percentage:02%%";
                label-margin-right = 2;
            };

            "module/memory" = {
                type = "internal/memory";
                interval = 2;
                label = "%{F#B5E8E0}%{F-} %percentage_used:02%%";
                label-margin = 2;
    
            };

            "module/volume" = {
                type = "internal/pulseaudio";
                format-volume = "<label-volume>";
                label-volume-foreground = "#D9E0EE";
                label-volume = "%{F#FAE3B0}墳 %{F-}%percentage:02%%";
                label-muted = "%{F#FAE3B0}婢 %{F-} 0%";
                label-muted-foreground = "#D9E0EE";

            };

        };
    };

    home.file = {
      ".local/bin/micmute" ={
          executable = true;
          text = ''
#!/bin/sh

if [ "$1" = "toggle" ]; then
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    polybar-msg hook mic 1
else

    mute="$(pactl get-source-mute @DEFAULT_SOURCE@)"
    if [ "$mute" = "Mute: yes" ]; then
        printf ""
    else
        printf ""
    fi
fi
          '';
      };

    };
}
