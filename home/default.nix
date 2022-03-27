{ pkgs, config, ... }:

{
  imports = [
    ./desktop/bspwm
#    ./desktop/awesome
    ./desktop/gtk
    ./desktop/picom
    ./desktop/polybar
    ./desktop/sxhkd
    ./desktop/xresources
    ./desktop/lockscreen

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
    ./programs/chromium
    ./programs/flameshot
    ./programs/rofi
    ./programs/zathura
    ./programs/discocss

    ./services/udiskie
    ./services/redshift
  ];
}
