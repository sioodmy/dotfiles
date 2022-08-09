{ pkgs, lib, config, fetchzip, inputs, ... }:
with lib;
let
  cfg = config.modules.desktop.swaylock;
  mkService = lib.recursiveUpdate {
    Unit.PartOf = [ "graphical-session.target" ];
    Unit.After = [ "graphical-session.target" ];
    Install.WantedBy = [ "awesome-session.target" ];
  };
in {
  options.modules.desktop.swaylock = { enable = mkEnableOption "swaylock"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ swaylock-effects ];

    programs.swaylock = {
      settings = {
        clock = true;
        color = "040c16";
        show-failed-attempts = true;
        indicator = true;
        indicator-radius = 200;
        indicator-thickness = 20;
        line-color = "040c16";
        ring-color = "17252A";
        inside-color = "040c16";
        key-hl-color = "92bbed";
        separator-color = "00000000";
        text-color = "cce9ea";
        text-caps-lock-color = "e2d06a";
        line-ver-color = "040c16";
        ring-ver-color = "17252A";
        inside-ver-color = "040c16";
        text-ver-color = "cce9ea";
        ring-wrong-color = "E6676B";
        text-wrong-color = "cce9ea";
        inside-wrong-color = "040c16";
        inside-clear-color = "040c16";
        text-clear-color = "cce9ea";
        ring-clear-color = "A2E4B8";
        bs-hl-color = "e6676b";
        line-uses-ring = true;
        grace = 2;
        datestr = "%d.%m";
        fade-in = "0.1";
      };
    };

  };
}
