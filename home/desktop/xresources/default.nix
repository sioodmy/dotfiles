{ config, pkgs, theme, ... }:

{
  xresources.extraConfig = with theme.colors;
    "\n        *background: #${bg}\n        *foreground: #${fg} \n        !! Gray\n        *color0: #${c0}\n        *color8: #${c8}\n\n        !! Red\n        *color1: #${c1}\n        *color9: #${c9}\n\n        !! Green\n        *color2: #${c2}\n        *color10: #${c10}\n\n        !! Yellow\n        *color3: #${c3}\n        *color11:  #${c11}\n\n        !! Blue\n        *color4: #${c4}\n        *color12: #${c12}\n\n        !! Maguve\n        *color5: #${c5}\n        *color13: #${c13}\n\n        !! Pink\n        *color6: #${c6}\n        *color14: #${c14}\n\n        !! Whites\n        *color7: #${c7}\n        *color15: #${c15}\n    ";

}
