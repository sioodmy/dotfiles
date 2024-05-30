{
  pkgs,
  lib,
  theme,
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
    style = import ./style.nix theme;
    systemd = {
      enable = true;
      target = "niri.service";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 5;
        modules-left = [
          "custom/search"
          "custom/weather"
          "backlight"
          "battery"
        ];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "network"];
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
        clock = {
          format = "{:%H:%M}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}% {power} 󱐋";
          format-charging = "{icon} 󰚥 {capacity} %";
          tooltip-format = "{timeTo}";
          format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        network = {
          format-wifi = "󰤨  {essid} {signalStrength}%";
          format-ethernet = "󰈀";
          format-alt = "󰤨";
          format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
        };
        pulseaudio = {
          scroll-step = 5;
          tooltip = true;
          tooltip-format = "{volume}% {format_source}";
          on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
          format = " {icon} {volume}%";
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
