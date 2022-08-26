{ pkgs, lib, config, fetchzip, inputs, stdenv, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
  mkService = lib.recursiveUpdate {
    Unit.PartOf = [ "graphical-session.target" ];
    Unit.After = [ "graphical-session.target" ];
    Install.WantedBy = [ "graphical-session.target" ];
  };
in {
  options.modules.desktop.hyprland = { enable = mkEnableOption "hyprland"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swaybg
      brightnessctl
      pamixer
      python39Packages.requests
      sway-contrib.grimshot
      wlogout
    ];

    home.pointerCursor.package = pkgs.nordzy-cursor-theme;
    home.pointerCursor.name = "Nordzy-cursors";
    home.pointerCursor.size = 16;
    home.pointerCursor.gtk.enable = true;

    home.file."pics/walls/wall.png".source = ./wall.png;
    home.file.".config/wlogout/icons".source = ./icons;
    home.file = {
      ".config/wlogout/style.css".text = ''
        * {
            background-image: none;
        }
        window {
            background-color: #2e3440;
        }
        button {
            color: #d8dee9;
            background-color: #434c5e;
            background-repeat: no-repeat;
            background-position: center;
            background-size: 25%;
            border-radius: 15px;
            margin: 7px;
            shadown: none;
        }
        button:focus, button:active, button:hover {
            background-color: #81a1c1;
        }
        #lock {
            background-image: url("./icons/lock.svg");
        }
        #logout {
            background-image: url("./icons/logout.svg");
        }
        #suspend {
            background-image: url("./icons/suspend.svg");
        }
        #hibernate {
            background-image: url("./icons/hibernate.svg");
        }
        #shutdown {
            background-image: url("./icons/shutdown.svg");
        }
        #reboot {
            background-image: url("./icons/reboot.svg");
        }
      '';
      ".config/wlogout/layout".text = ''
        {
            "label" : "lock",
            "action" : "swaylock",
            "text" : "Lock",
            "keybind" : "l"
        }
        {
            "label" : "hibernate",
            "action" : "systemctl hibernate",
            "text" : "Hibernate",
            "keybind" : "h"
        }
        {
            "label" : "logout",
            "action" : "loginctl terminate-user $USER",
            "text" : "Logout",
            "keybind" : "e"
        }
        {
            "label" : "shutdown",
            "action" : "systemctl poweroff",
            "text" : "Shutdown",
            "keybind" : "s"
        }
        {
            "label" : "suspend",
            "action" : "swaylock & systemctl suspend",
            "text" : "Suspend",
            "keybind" : "u"
        }
        {
            "label" : "reboot",
            "action" : "systemctl reboot",
            "text" : "Reboot",
            "keybind" : "r"
        }
      '';
    };

    services.wlsunset = {
      enable = true;
      latitude = "52.14";
      longitude = "21.07";
      systemdTarget = "graphical-session.target";
    };

    systemd.user.services = {
      swaybg = mkService {
        Unit.Description = "Wallpaper chooser";
        Service.ExecStart =
          "${pkgs.swaybg}/bin/swaybg -i /home/sioodmy/pics/walls/wall.png";
      };
    };
  };
}
