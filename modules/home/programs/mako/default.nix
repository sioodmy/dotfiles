{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.services.mako;
in {
  options.modules.services.mako = { enable = mkEnableOption "mako"; };

  config = mkIf cfg.enable {
    programs.mako = {
      enable = true;

      backgroundColor = "#040c16";
      textColor = "#cce9ea";
      borderColor = "#92bbed";
      padding = "15";
      defaultTimeout = 7000;
      borderSize = 3;
      borderRadius = 10;
      height = 300;
      font = "monospace 15";

      extraConfig = ''
        [urgency=high]
        border-color=#E6676B
      '';
    };
  };
}
