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
    gradient_count = 8
    gradient = 1
    gradient_color_1 = '#B5E8E0'
    gradient_color_2 = '#89DCEB'
    gradient_color_3 = '#96CDFB'
    gradient_color_4 = '#cba6f7'
    gradient_color_5 = '#f5c2e7'
    gradient_color_6 = '#f38ba8'
    gradient_color_7 = '#f5e0dc'
    gradient_color_8 = '#f2cdcd'
    [smoothing]
    integral = 77
    gravity = 100
    '';
  };
}
