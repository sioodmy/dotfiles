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
    ./desktop/waybar
    ./desktop/hyprland

    ./programs/vim
    ./programs/rofi
    ./programs/tmux
    ./programs/brave
    ./programs/wofi
    ./programs/kitty
    ./programs/neofetch
    ./programs/firefox
    ./programs/zathura
    ./programs/mako
  ];

}
