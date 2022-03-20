{ pkgs, config, ... }:

{
  imports = [
    ./desktop/betterlockscreen
    ./desktop/bspwm
    ./desktop/gtk
    ./desktop/picom
    ./desktop/polybar
    ./desktop/sxhkd
    ./desktop/xresources

    ./cli/bat
    ./cli/fzf
    ./cli/git
    ./cli/gpg
    ./cli/music
    ./cli/nvim
    ./cli/pass
    ./cli/xdg
    ./cli/zsh

    ./programs/alacritty
    ./programs/dunst
    ./programs/firefox
    ./programs/flameshot
    ./programs/rofi
    ./programs/zathura
    ./programs/discocss

    ./services/udiskie
    ./services/redshift
  ];
}
