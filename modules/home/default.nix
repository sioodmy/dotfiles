{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "22.05";
  imports = [
    ./packages.nix

    ./desktop/bspwm
    ./desktop/awesome
    ./desktop/gtk
    ./desktop/picom
    ./desktop/xresources
    ./desktop/eww
    ./desktop/lockscreen

    ./cli/bat
    ./cli/fzf
    ./cli/git
    ./cli/gpg
    ./cli/lf
    ./cli/cava
    ./cli/music
    ./cli/btm
    ./cli/nvim
    ./cli/xdg
    ./cli/zsh

    ./programs/kitty
    ./programs/dunst
    ./programs/chromium
    ./programs/qutebrowser
    ./programs/rofi
    ./programs/zathura
    ./programs/discocss
    ./programs/mpv

    ./services/udiskie
    ./services/sxhkd
    ./services/fusuma
    ./services/redshift
  ];

}
