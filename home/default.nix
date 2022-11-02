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
    ./tmux
    ./tools
    ./waybar
    ./zathura
    ./zathura
  ];
}
