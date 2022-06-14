{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.mpv;
in {
  options.modules.programs.mpv = { enable = mkEnableOption "mpv"; };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        mpris
        thumbnail
        sponsorblock
        convert
        cutter
      ];
    };
  };
}
