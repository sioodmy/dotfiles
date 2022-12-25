{
  pkgs,
  lib,
  config,
  ...
}: let
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
  xdg.configFile."waybar/style.css".text = import ./style.nix;
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      patchPhase = ''
        substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch workspace \" + name_; system(command.c_str());"
      '';
    });

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        spacing = 7;
        fixed-center = false;
        exclusive = true;
        modules-left = [
          "custom/search"
          "wlr/workspaces"
          "custom/lock"
          "backlight"
          "battery"
        ];
        modules-center = [
          "custom/weather"
          "clock"
        ];
        modules-right = ["pulseaudio" "network" "custom/power"];
        "wlr/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          active-only = false;
          format-icons = {
            default = "";
            active = " 󰮯";
          };
        };
        "custom/search" = {
          format = " ";
          tooltip = false;
          on-click = "${pkgs.killall}/bin/killall rofi || ${config.programs.rofi.package}/bin/rofi -show drun";
        };

        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 30;
          exec = "${waybar-wttr}/bin/waybar-wttr";
          return-type = "json";
        };
        "custom/lock" = {
          tooltip = false;
          on-click = "sh -c '(sleep 0.5s; ${pkgs.swaylock}/bin/swaylock --grace 0)' & disown";
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
          format = "";
        };
        "custom/power" = {
          tooltip = false;
          on-click = let
            doas = pkgs.doas + "/bin/doas";
            rofi = config.programs.rofi.package + "/bin/rofi";
            poweroff = pkgs.systemd + "/bin/poweroff";
            reboot = pkgs.systemd + "/bin/reboot";
          in
            pkgs.writeShellScript "shutdown-waybar" ''

              #!/bin/sh

              off=" Shutdown"
              reboot=" Reboot"
              cancel=" Cancel"

              sure="$(printf '%s\n%s\n%s' "$off" "$reboot" "$cancel" |
              	${rofi} -dmenu -p ' Are you sure?')"

              if [ "$sure" = "$off" ]; then
              	${doas} ${poweroff}
              elif [ "$sure" = "$reboot" ]; then
              	${doas} ${reboot}
              fi
            '';
          format = "襤 ";
        };
        clock = {
          format = "{:%b %d %H:%M}";
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
          format = "{icon} {capacity}%";
          format-charging = "";
          format-plugged = "";
          format-alt = "{icon} {capacity}%";
          format-icons = ["" "" "" "" "" "" "" "" "" "" "" ""];
        };
        network = {
          format-wifi = "󰤨 {essid} {signalStrength}%";
          format-ethernet = "󰤨 {bandwidthTotalBytes}";
          format-alt = "󰤨 {ipaddr}/{ifname}";
          format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
        };
        pulseaudio = {
          scroll-step = 5;
          tooltip = false;
          format = "{icon} {volume}%";
          format-icons = {default = ["" "" "墳"];};
          on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
        };
      };
    };
  };
}
