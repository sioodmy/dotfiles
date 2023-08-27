{
  pkgs,
  lib,
  config,
  ...
}: let
  get-crypto-price =
    pkgs.writeShellScriptBin "get-crypto-price"
    ''
      #!/bin/sh
      price="$(curl -s https://api.binance.com/api/v3/ticker/price?symbol=$1 | ${lib.getExe pkgs.jq} '.price' | sed 's/\"//g')"
      printf "%.2f" $price
    '';

  mullvad-status =
    pkgs.writeShellScriptBin "mullvad-status"
    ''
      #!/bin/sh
      mullvad status | awk '{print $1;}'
    '';
in {
  xdg.configFile."waybar/style.css".text = import ./style.nix;
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        width = 55;
        spacing = 7;
        fixed-center = false;
        margin-left = 6;
        margin-top = 9;
        margin-bottom = 9;
        margin-right = null;
        exclusive = true;
        modules-left = [
          "custom/search"
          "hyprland/workspaces"
          "custom/lock"
          "backlight"
          "battery"
          # "custom/eth"
        ];
        modules-center = [
          "custom/weather"
          "clock"
        ];
        modules-right = ["pulseaudio" "network" "custom/swallow" "custom/power"];
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
          on-click = "lib.getBin config.programs.anyrun.package}/anyrun";
        };

        "custom/weather" = let
          weather = pkgs.stdenv.mkDerivation {
            name = "waybar-wttr";
            buildInputs = [
              (pkgs.python39.withPackages
                (pythonPackages: with pythonPackages; [requests pyquery]))
            ];
            unpackPhase = "true";
            installPhase = ''
              mkdir -p $out/bin
              cp ${./weather.py} $out/bin/weather
              chmod +x $out/bin/weather
            '';
          };
        in {
          format = "{}";
          tooltip = true;
          interval = 30;
          exec = "${weather}/bin/weather";
          return-type = "json";
        };
        "custom/eth" = {
          format = "󰡪 {}";
          tooltip = true;
          interval = 15;
          exec = "${lib.getExe get-crypto-price} ETHUSDT";
        };
        "custom/vpn" = {
          format = " VPN {}";
          tooltip = true;
          interval = 1;
          exec = "${lib.getBin mullvad-status}/mullvad-status";
        };
        "custom/lock" = {
          tooltip = false;
          on-click = "sh -c '(sleep 0.5s; ${pkgs.gtklock}/bin/gtklock)' & disown";
          format = "";
        };
        "custom/swallow" = {
          tooltip = false;
          on-click = let
            hyprctl = config.wayland.windowManager.hyprland.package + "/bin/hyprctl";
            notify-send = pkgs.libnotify + "/bin/notify-send";
            rg = pkgs.ripgrep + "/bin/rg";
          in
            pkgs.writeShellScript "waybar-swallow" ''
              #!/bin/sh
              if ${hyprctl} getoption misc:enable_swallow | ${rg}/bin/rg -q "int: 1"; then
              	${hyprctl} keyword misc:enable_swallow false >/dev/null &&
              		${notify-send} "Hyprland" "Turned off swallowing"
              else
              	${hyprctl} keyword misc:enable_swallow true >/dev/null &&
              		${notify-send} "Hyprland" "Turned on swallowing"
              fi
            '';
          format = "󰘻";
        };
        "custom/power" = {
          tooltip = false;
          # TODO
          format = "󰐥";
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
        cpu = {
          interval = 5;
          format = "  {}%";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "";
          format-plugged = "";
          format-alt = "{icon} {capacity}%";
          format-icons = ["" "" "" "" "" "" "" "" "" "" "" ""];
        };
        network = let
          nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        in {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-alt = "󱛇";
          format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
          on-click-right = "${nm-editor}";
        };
        pulseaudio = {
          scroll-step = 5;
          tooltip = true;
          tooltip-format = "{volume}";
          on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
          format = "{icon}";
          format-muted = "󰝟 ";
          format-icons = {
            default = ["" "" " "];
          };
        };
      };
    };
  };
}
