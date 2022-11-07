{
  inputs,
  pkgs,
  config,
  ...
}:
# glue all configs together
{
  home.stateVersion = "22.05";
  imports = [
    ./packages.nix

    ./gtk
    ./kitty
    ./mako
    ./rofi
    ./shell
    ./swaylock
    ./tools
    ./waybar
    ./hyprland
    inputs.hyprland.homeManagerModules.default
  ];
}
