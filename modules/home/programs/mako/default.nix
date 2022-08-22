{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.mako;
in {
  options.modules.programs.mako = { enable = mkEnableOption "mako"; };

  config = mkIf cfg.enable {
    programs.mako = {
      enable = true;

      backgroundColor = "#3b4252";
      textColor = "#d8dee9";
      borderColor = "#434c5e";
      padding = "15";
      defaultTimeout = 7000;
      borderSize = 3;
      borderRadius = 10;
      height = 300;
      font = "monospace 15";

      extraConfig = ''
        [urgency=high]
        border-color=#bf616a
      '';

    };
  };
}
