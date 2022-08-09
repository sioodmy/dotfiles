{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "22.05";
  imports = [
    ./packages.nix

    ./desktop/gtk
    ./desktop/xresources
    ./desktop/swaylock
    ./desktop/hyprland

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
    ./programs/minivim
    ./programs/foot
    ./programs/chromium
    ./programs/zathura
    ./programs/mpv
    ./programs/mako

    ./services/udiskie
    ./services/sxhkd
  ];

}
