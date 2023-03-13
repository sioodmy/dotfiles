{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  home.packages = with pkgs; [swaylock-effects];

  programs.swaylock = {
    settings = {
      clock = true;
      color = "1e1e2e";
      font = "Work Sans";
      show-failed-attempts = false;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-color = "1e1e2e";
      ring-color = "585b70";
      inside-color = "1e1e2e";
      key-hl-color = "f2cdcd";
      separator-color = "00000000";
      text-color = "cdd6f4";
      text-caps-lock-color = "";
      line-ver-color = "f2cdcd";
      ring-ver-color = "f2cdcd";
      inside-ver-color = "1e1e2e";
      text-ver-color = "cdd6f4";
      ring-wrong-color = "f38ba8";
      text-wrong-color = "eba0ac";
      inside-wrong-color = "1e1e2e";
      inside-clear-color = "1e1e2e";
      text-clear-color = "cdd6f4";
      ring-clear-color = "a6e3a1";
      line-clear-color = "1e1e2e";
      line-wrong-color = "1e1e2e";
      bs-hl-color = "f38ba8";
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
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 310;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
    ];
  };

  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];
}
