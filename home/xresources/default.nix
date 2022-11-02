{ config, pkgs, ... }: {
  xresources.extraConfig = ''
    *background: #1e1e2e
    *foreground: #cdd6f4
    st.borderpx: 32
    st.font: monospace:pixelsize=19

    ! Gray
    *color0: #45475a
    *color8: #585b70

    ! Red
    *color1: #f38ba8
    *color9: #f38ba8

    ! Green
    *color2: #a6e3a1
    *color10: #a6e3a1

    ! Yellow
    *color3: #f9e2af
    *color11:  #f9e2af

    ! Blue
    *color4: #89b4fa
    *color12: #89b4fa

    ! Maguve
    *color5: #f5c2e7
    *color13: #f5c2e7

    ! Pink
    *color6: #94e2d5
    *color14: #94e2d5

    ! Whites
    *color7: #bac2de
    *color15: #a6adc8
  '';
}
