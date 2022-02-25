{ config, pkgs, ... }:

{
    xresources.extraConfig = ''
        *background: #1E1E2E
        *foreground: #D9E0EE 
        ! Gray
        *color0: #6E6C7E
        *color8: #988BA2

        ! Red
        *color1: #F28FAD
        *color9: #F28FAD

        ! Green
        *color2: #ABE9B3
        *color10: #ABE9B3

        ! Yellow
        *color3: #FAE3B0
        *color11:  #FAE3B0

        ! Blue
        *color4: #96CDFB
        *color12: #96CDFB

        ! Maguve
        *color5: #DDB6F2
        *color13: #DDB6F2

        ! Pink
        *color6: #F5C2E7
        *color14: #F5C2E7

        ! Whites
        *color7: #C3BAC6
        *color15: #D9E0EE
    '';


}
