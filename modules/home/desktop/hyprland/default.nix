{ pkgs, lib, config, fetchzip, inputs, stdenv, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
  mkService = lib.recursiveUpdate {
    Unit.PartOf = [ "graphical-session.target" ];
    Unit.After = [ "graphical-session.target" ];
    Install.WantedBy = [ "graphical-session.target" ];
  };
  ocr = pkgs.writeShellScriptBin "ocr" ''
    #!/bin/bash
    grim -g "$(slurp -c d8dee9ee -b 2e3440dd -w 2)" /tmp/ocr.png && tesseract /tmp/ocr.png /tmp/ocr-output && wl-copy < /tmp/ocr-output.txt && notify-send "OCR" "Text copied!" && rm /tmp/ocr-output.txt -f
  '';

in {
  options.modules.desktop.hyprland = { enable = mkEnableOption "hyprland"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swaybg
      brightnessctl
      pamixer
      python39Packages.requests
      sway-contrib.grimshot
      slurp
      tesseract5
      ocr
      grim
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
        color: #eceff4;
            background-color: #2e3440;
            border-style: solid;
            border-width: 2px;
            background-repeat: no-repeat;
            background-position: center;
            background-size: 25%;
        }
        button:focus, button:active, button:hover {
            background-color: #4c566a;
            outline-style: none;
        }
        #lock {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
        }
        #logout {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
        }
        #suspend {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
        }
        #hibernate {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
        }
        #shutdown {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
        }
        #reboot {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
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

    services.gammastep = {
      enable = true;
      provider = "geoclue2";
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
