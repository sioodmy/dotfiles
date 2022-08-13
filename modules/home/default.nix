{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "22.05";
  imports = [
    ./packages.nix
    ./tools
    ./shell

    ./desktop/gtk
    ./desktop/xresources
    ./desktop/swaylock
    ./desktop/hyprland

    ./programs/vim
    ./programs/wofi
    ./programs/foot
    ./programs/zathura
    ./programs/mpv
    ./programs/mako
  ];

}
