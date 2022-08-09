{ pkgs, lib, config, fetchzip, inputs, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
  mkService = lib.recursiveUpdate {
    Unit.PartOf = [ "graphical-session.target" ];
    Unit.After = [ "graphical-session.target" ];
    Install.WantedBy = [ "awesome-session.target" ];
  };
in {
  options.modules.desktop.hyprland = { enable = mkEnableOption "hyprland"; };

  config = mkIf cfg.enable {

    systemd.user.services = {
      swaybg = mkService {
        Unit.Description = "Wallpaper chooser";
        Service.ExecStart = "${pkgs.swaybg}/bin/swaybg -c #17252A";
      };
    };
  };
}
