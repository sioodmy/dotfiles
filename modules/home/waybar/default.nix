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
    # This version just works for my configuration
    # also this is not gentoo, I dont want to compile EVERYSINGLE WAYBAR UPDATE
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "Alexays";
        repo = "Waybar";
        rev = "afa590f781c85a95c45138727510244b66ca674c";
        sha256 = "R8/X+mTDAMyFUp6czi6+afD+IP1MAu6xw+ysSEb/r8w=";
      };
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      patchPhase = ''
        substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"hyprctl dispatch workspace \" + name_; system(command.c_str());"
      '';
    });

    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        width = 60;
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
        modules-center = [];
        modules-right = ["pulseaudio" "network" "custom/swallow" "clock" "custom/power"];
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
          on-click = "killall rofi || ${pkgs.rofi}/bin/rofi -show drun";
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
          exec = "${waybar-wttr}";
          return-type = "json";
        };
        "custom/lock" = {
          tooltip = false;
          on-click = "sh -c '(sleep 0.5s; ${pkgs.swaylock}/bin/swaylock --grace 0)' & disown";
          format = "";
        };
        "custom/swallow" = {
          tooltip = false;
          on-click = "${./waybar-swallow.sh}";
          format = "";
        };
        "custom/power" = {
          tooltip = false;
          on-click = "${./shutdown.sh} &";
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
          format-icons = ["" "" "" "" "" "" "" "" ""];
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
          format-icons = ["" "" "" "" "" "" "" "" "" "" "" ""];
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
          tooltip = false;
          format = "{icon}";
          format-icons = {default = ["" "" "墳"];};
          on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
        };
      };
    };
  };
}
