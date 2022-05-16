{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.xresources;
in {
  options.modules.desktop.xresources = {
    enable = mkEnableOption "xresources";
  };

  config = mkIf cfg.enable {
    xresources.extraConfig = ''

      #define nord0 #2E3440
      #define nord1 #3B4252
      #define nord2 #434C5E
      #define nord3 #4C566A
      #define nord4 #D8DEE9
      #define nord5 #E5E9F0
      #define nord6 #ECEFF4
      #define nord7 #8FBCBB
      #define nord8 #88C0D0
      #define nord9 #81A1C1
      #define nord10 #5E81AC
      #define nord11 #BF616A
      #define nord12 #D08770
      #define nord13 #EBCB8B
      #define nord14 #A3BE8C
      #define nord15 #B48EAD

      *.foreground:   nord4
      *.background:   nord0
      *.cursorColor:  nord4
      *fading: 35
      *fadeColor: nord3

      *.color0: nord1
      *.color1: nord11
      *.color2: nord14
      *.color3: nord13
      *.color4: nord9
      *.color5: nord15
      *.color6: nord8
      *.color7: nord5
      *.color8: nord3
      *.color9: nord11
      *.color10: nord14
      *.color11: nord13
      *.color12: nord9
      *.color13: nord15
      *.color14: nord7
      *.color15: nord6
    '';

  };
}
