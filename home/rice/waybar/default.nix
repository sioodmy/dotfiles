{
  pkgs,
  lib,
  ...
}:
with lib; let
  waybar-wttr = pkgs.stdenv.mkDerivation {
    name = "waybar-wttr";
    buildInputs = [
      (pkgs.python39.withPackages
        (pythonPackages: with pythonPackages; [requests]))
    ];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      cp ${./waybar-wttr.py} $out/bin/waybar-wttr
      chmod +x $out/bin/waybar-wttr
    '';
  };
in {
  home.packages = [waybar-wttr];
  programs.waybar = {
    enable = true;
    style = import ./style.nix;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        width = 57;
        spacing = 7;
        modules-left = [
          "custom/search"
          "hyprland/workspaces"
          "custom/lock"
          "custom/weather"
          "backlight"
          "battery"
        ];
        modules-center = [];
        modules-right = ["pulseaudio" "network" "clock" "custom/power"];
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          active-only = false;
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };

          persistent_workspaces = {
            "*" = 5;
          };
        };
        "custom/search" = {
          format = " ";
          tooltip = false;
          on-click = "${pkgs.tofi}/bin/tofi-drun";
        };

        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 3600;
          exec = "waybar-wttr";
          return-type = "json";
        };
        "custom/lock" = {
          tooltip = false;
          on-click = "sh -c '(sleep 0.5s; swaylock)' & disown";
          format = "";
        };
        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "";
        };
        clock = {
          format = ''
            {:%H
            %M}'';
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        backlight = {
          format = "{icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "{icon}\n󰚥";
          tooltip-format = "{timeTo} {capacity}% 󱐋{power}";
          format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        network = {
          format-wifi = "󰤨";
          format-ethernet = "󰤨";
          format-alt = "󰤨";
          format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
        };
        pulseaudio = {
          scroll-step = 5;
          tooltip = true;
          tooltip-format = "{volume}% {format_source}";
          on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
          format = " {icon}\n{volume}%";
          format-bluetooth = "󰂯 {icon} {volume}%";
          format-muted = "󰝟 ";
          format-icons = {
            default = ["" "" " "];
          };
        };
      };
    };
  };
}
