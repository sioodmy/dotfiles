{ pkgs, lib, config, fetchzip, inputs, ... }:
with lib;
let
  cfg = config.modules.desktop.waybar;
  waybar-wttr = pkgs.stdenv.mkDerivation {
    name = "waybar-wttr";
    buildInputs = [
      (pkgs.python39.withPackages
        (pythonPackages: with pythonPackages; [ requests ]))
    ];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      cp ${./waybar-wttr.py} $out/bin/waybar-wttr
      chmod +x $out/bin/waybar-wttr
    '';
  };

in {
  options.modules.desktop.waybar = { enable = mkEnableOption "waybar"; };

  config = mkIf cfg.enable {
    home.file.".config/waybar/style.css".text = import ./style.nix;
    home.packages = [ waybar-wttr ];
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "left";
          width = 57;
          spacing = 7;
          modules-left = [
            "custom/search"
            "wlr/workspaces"
            "custom/lock"
            "custom/weather"
            "custom/todo"
            "backlight"
            "battery"
          ];
          modules-center = [ ];
          modules-right = [ "pulseaudio" "network" "clock" "custom/power" ];
          "wlr/workspaces" = {
            on-click = "activate";
            format = "{icon}";
            active-only = false;
            format-icons = {
              default = "";
              focused = "";
            };
          };
          "custom/search" = {
            format = " ";
            tooltip = false;
            on-click = "killall rofi || rofi -show drun";
          };
          "custom/todo" = {
            format = "{}";
            tooltip = true;
            interval = 7;
            exec = "${./todo.sh}";
            return-type = "json";
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
            on-click = "sh -c '(sleep 0.5s; swaylock --grace 0)' & disown";
            format = "";
          };
          "custom/power" = {
            tooltip = false;
            on-click = "wlogout &";
            format = "襤";
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
            format-icons = [ "" "" "" "" "" "" "" "" "" ];
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}";
            format-charging = "";
            format-plugged = "";
            format-alt = "{icon}";
            format-icons = [ "" "" "" "" "" "" "" "" "" "" "" "" ];
          };
          network = {
            format-wifi = "󰤨";
            format-ethernet = "󰤨";
            format-alt = "󰤨";
            format-disconnected = "󰤭";
            tooltip-format =
              "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
          };
          pulseaudio = {
            scroll-step = 5;
            tooltip = false;
            format = "{icon}";
            format-icons = { default = [ "" "" "墳" ]; };
            on-click = "killall pavucontrol || pavucontrol";
          };
        };

      };
    };

  };
}
