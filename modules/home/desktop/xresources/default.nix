{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.xresources;
in {
  options.modules.desktop.xresources = {
    enable = mkEnableOption "xresources";
  };

  config = mkIf cfg.enable {
    xresources.extraConfig = ''
      *background: #24273A
      *foreground: #CAD3F5
      st.borderpx: 32
      st.font: monospace:pixelsize=19

      ! Gray
      *color0: #494D64
      *color8: #5B6078

      ! Red
      *color1: #ED8796
      *color9: #ED8796

      ! Green
      *color2: #A6DA95
      *color10: #A6DA95

      ! Yellow
      *color3: #EED49F
      *color11:  #EED49F

      ! Blue
      *color4: #8AADF4
      *color12: #8AADF4

      ! Maguve
      *color5: #F5BDE6
      *color13: #F5BDE6

      ! Pink
      *color6: #8BD5CA
      *color14: #8BD5CA

      ! Whites
      *color7: #B8C0E0
      *color15: #A5ADCB
    '';

  };
}
