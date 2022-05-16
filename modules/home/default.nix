{ inputs, pkgs, config, ... }:

{
  imports = [
    ./packages.nix

    ./desktop/bspwm
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
    ./programs/firefox
    ./programs/qutebrowser
    ./programs/rofi
    ./programs/zathura
    ./programs/discocss

    ./services/udiskie
    ./services/sxhkd
    ./services/fusuma
    ./services/redshift
  ];


}
