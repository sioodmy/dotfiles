{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.foot;
in {
  options.modules.programs.foot = { enable = mkEnableOption "foot"; };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "monospace:size=14:line-height=16px";
          pad = "30x30";
        };
        colors = {
          foreground = "CDD6F4";
          background = "1E1E2E";
          ## Normal/regular colors (color palette 0-7)
          regular0 = "45475A"; # black
          regular1 = "F38BA8";
          regular2 = "A6E3A1";
          regular3 = "F9E2AF";
          regular4 = "89B4FA";
          regular5 = "F5C2E7";
          regular6 = "94E2D5";
          regular7 = "BAC2DE";

          bright0 = "585B70"; # bright black
          bright1 = "F38BA8"; # bright red
          bright2 = "A6E3A1"; # bright green
          bright3 = "F9E2AF"; # bright yellow
          bright4 = "89B4FA";
          bright5 = "F5C2E7"; # bright magenta
          bright6 = "94E2D5"; # bright cyan
          bright7 = "A6ADC8"; # bright white
        };
      };
    };
  };
}
