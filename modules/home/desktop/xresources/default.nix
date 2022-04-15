{ config, lib, pkgs, theme, ... }:
with lib;
let cfg = config.modules.desktop.xresources;
in {
  options.modules.desktop.xresources = {
    enable = mkEnableOption "xresources";
  };

  config = mkIf cfg.enable {
    xresources.extraConfig = with theme.colors; ''

      *background: #${bg}
      *foreground: #${fg} 
      !! Gray
      *color0: #${c0}
      *color8: #${c8}

      !! Red
      *color1: #${c1}
      *color9: #${c9}

      !! Green
      *color2: #${c2}
      *color10: #${c10}

      !! Yellow
      *color3: #${c3}
      *color11:  #${c11}

      !! Blue
      *color4: #${c4}
      *color12: #${c12}

      !! Maguve
      *color5: #${c5}
      *color13: #${c13}

      !! Pink
      *color6: #${c6}
      *color14: #${c14}

      !! Whites
      *color7: #${c7}
      *color15: #${c15}
          '';

  };
}
