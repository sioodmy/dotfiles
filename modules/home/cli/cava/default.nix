{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.cli.cava;
in {
  options.modules.cli.cava = { enable = mkEnableOption "cava"; };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.cava ];

    home.file.".config/cava/config".text = ''

      [general]
      bar_width = 4

      [color]
      gradient = 1
      gradient_count = 2
      gradient_color_1 = '#81a1c1'
      gradient_color_2 = '#5e81ac'

      [smoothing]
      integral = 77
      gravity = 100
    '';
  };
}
