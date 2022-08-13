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
    home.packages = with pkgs; [ swaybg ];

    systemd.user.services = {
      swaybg = mkService {
        Unit.Description = "Wallpaper chooser";
        Service.ExecStart =
          "${pkgs.swaybg}/bin/swaybg -i /home/sioodmy/pics/walls/space.png";
      };
      waybar = mkService {
        Unit.Description = "Waybar status bar";
        Service.ExecStart = "${pkgs.waybar}/bin/waybar";
      };
      eww = mkService {
        Unit.Description = "Eww widgets";
        Service.ExecStartPre =
          "${inputs.eww.packages."x86_64-linux".eww-wayland}/bin/eww daemon";
        Service.ExecStart = "${
            inputs.eww.packages."x86_64-linux".eww-wayland
          }/bin/eww open calendar";
        Service.ExecStop =
          "${inputs.eww.packages."x86_64-linux".eww-wayland}/bin/eww kill";

      };

    };
  };
}
