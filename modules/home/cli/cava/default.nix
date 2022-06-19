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
    gradient_color_4 = '#c6a0f6'
    gradient_color_5 = '#f5bde6'
    gradient_color_6 = '#ed8796'
    gradient_color_7 = '#f4dbd6'
    gradient_color_8 = '#f0c6c6'
    [smoothing]
    integral = 77
    gravity = 100
    '';
  };
}
