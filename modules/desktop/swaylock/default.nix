{ pkgs, lib, config, fetchzip, inputs, ... }:
with lib;
let cfg = config.modules.desktop.swaylock;
in {
  options.modules.desktop.swaylock = { enable = mkEnableOption "swaylock"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ swaylock-effects ];

    programs.swaylock = {
      settings = {
        clock = true;
        color = "303446";
        font = "Work Sans";
        show-failed-attempts = false;
        indicator = true;
        indicator-radius = 200;
        indicator-thickness = 20;
        line-color = "303446";
        ring-color = "626880";
        inside-color = "303446";
        key-hl-color = "eebebe";
        separator-color = "00000000";
        text-color = "c6d0f5";
        text-caps-lock-color = "";
        line-ver-color = "eebebe";
        ring-ver-color = "eebebe";
        inside-ver-color = "303446";
        text-ver-color = "c6d0f5";
        ring-wrong-color = "e78284";
        text-wrong-color = "e78284";
        inside-wrong-color = "303446";
        inside-clear-color = "303446";
        text-clear-color = "c6d0f5";
        ring-clear-color = "a6d189";
        line-clear-color = "303446";
        line-wrong-color = "303446";
        bs-hl-color = "e78284";
        line-uses-ring = false;
        grace = 2;
        grace-no-mouse = true;
        grace-no-touch = true;
        datestr = "%d.%m";
        fade-in = "0.1";
        ignore-empty-password = true;
      };
    };

    services.swayidle = {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "swaylock";
        }
        {
          event = "lock";
          command = "swaylock";
        }
      ];
      timeouts = [
        {
          timeout = 300;
          command = "hyprctl dispatch dpms off";
          resumeCommand = "hyprctl dispatch dpms on";
        }
        {
          timeout = 310;
          command = "loginctl lock-session";
        }
      ];
    };
  };
}
