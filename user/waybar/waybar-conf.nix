{pkgs, ...}: let
  settings = {
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
    ];
    modules-center = [
      "custom/weather"
      "clock"
    ];
    modules-right = ["pulseaudio" "network" "custom/power"];

    "custom/search" = {
      format = " ";
      tooltip = false;
      on-click = "lib.getBin config.programs.anyrun.package/anyrun";
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
      format = "{icon}";
      format-charging = "󰂄";
      format-plugged = "󰂄";
      tooltip-format = "{timeTo} | {capacity}%";
      format-alt = "{icon}";
      format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
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
  };
in
  pkgs.writeText "waybar-config.json" (builtins.toJSON settings)
