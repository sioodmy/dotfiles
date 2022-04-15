{ config, theme, lib, pkgs, ... }:
with lib;
let cfg = config.modules.cli.cava;
in {
  options.modules.cli.cava = { enable = mkEnableOption "cava"; };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.cava ];

    home.file.".config/cava/config".text = with theme.colors; ''


      [general]
      bar_width = 4

      [color]
      gradient = 1
      gradient_count = 8
      gradient_color_1 = '#B5E8E0'
      gradient_color_2 = '#89DCEB'
      gradient_color_3 = '#96CDFB'
      gradient_color_4 = '#DDB6F2'
      gradient_color_5 = '#F5C2E7'
      gradient_color_6 = '#E8A2AF'
      gradient_color_7 = '#F2CDCD'
      gradient_color_8 = '#F5E0DC'

      [smoothing]
      integral = 77
      gravity = 100
    '';
  };
}
