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
          foreground = "cce9ea";
          background = "040c16";
          regular0 = "1b2c31";
          regular1 = "FF7377";
          regular2 = "AAF0C1";
          regular3 = "eadd94";
          regular4 = "bdd6f4";
          regular5 = "f9ecf7";
          regular6 = "b3ffff";
          regular7 = "edf7f8";

          bright0 = "17252A";
          bright1 = "E6676B";
          bright2 = "A2E4B8";
          bright3 = "e2d06a";
          bright4 = "92bbed";
          bright5 = "ecc6e8";
          bright6 = "80ffff";
          bright7 = "cfebec";
        };
      };
    };
  };
}
