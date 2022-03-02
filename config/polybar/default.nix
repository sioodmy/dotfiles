{ pkgs, config, theme, ...}:

{
    services.polybar = {
        enable = true;
        package = pkgs.polybar.override {
            pulseSupport = true;
            mpdSupport = true;
        };

        script = ''
          polybar top &
        '';
        config = with theme.colors; {
            "bar/top" = {
                monitor = "\${env:MONITOR}";
                width = "98%";
                offset-x = "1%";
                offset-y = "1%";
                height = 30;
                radius = 0;
                modules-left = "date";
                modules-center = "bspwm";
                modules-right = "mpd volume memory cpu";
                font-0 = "${font}:style=Medium:pixelsize=14;3";
                font-1 = "unifont:fontformat=truetype:size=14:antialias=false;3";
                font-2 = "Twitter Color Emoji:pixelsize=14;3";
                background = "${bg}";
            };

            "module/date" = {
                type = "internal/date";
                internal = 5;
                date = "%d.%m.%y";
                time = "%H:%M";
                label = "%{A1:dunstify \"Calendar\" \"AS\":}%{F${ac}}%{F-} %time%  %{F${ac}}%{F-} %date%%{A}"; 
                label-margin = 2;
            };

            "module/bspwm" = {
                type = "internal/bspwm";
                label-focused = "";
                label-focused-padding = "1.5";
                label-focused-foreground = "${ac}";
                label-foreground = "${fg}";

                label-occupied = "";
                label-occupied-padding = "1.5";

                label-empty = "";
                label-empty-padding = "1.5";

                label-urgent = "";
                label-urgent-padding = "1.5";
            };

            "module/cpu" = {
                type = "internal/cpu";
                interval = 2;
                label = "%{F${ac}}%{F-} %percentage:02%%";
                label-margin-right = 2;
            };

            "module/memory" = {
                type = "internal/memory";
                interval = 2;
                label = "%{F${ac}}%{F-} %percentage_used:02%%";
                label-margin = 2;
    
            };

            "module/volume" = {
                type = "internal/pulseaudio";
                format-volume = "<label-volume>";
                label-volume-foreground = "#D9E0EE";
                label-volume = "%{F${ac}}墳 %{F-}%percentage:02%%";
                label-muted = "%{F${ac}}婢 %{F-} 0%";
                label-muted-foreground = "#D9E0EE";

            };

            "module/mpd" = {
              type = "internal/mpd";
              host = "127.0.0.1";
              port = "6600";
              internal = 2;
              format-online = "%{F${ac}}<toggle>%{F}";
              label-song = "%artist% - %title%";
              icon-play = " ";
              icon-pause = " ";


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
