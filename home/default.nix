{ inputs, pkgs, config, ... }:

{
  imports = [
    ./desktop/bspwm
    ./desktop/gtk
    ./desktop/picom
    ./desktop/sxhkd
    ./desktop/xresources
    ./desktop/lockscreen
    ./desktop/eww

    ./cli/bat
    ./cli/fzf
    ./cli/git
    ./cli/gpg
    ./cli/music
    ./cli/nvim
    ./cli/pass
    ./cli/xdg
    ./cli/zsh

    ./programs/kitty
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
