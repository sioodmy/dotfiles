{
  inputs,
  pkgs,
  config,
  lib,
  self,
  ...
}:
# glue all configs together
{
  config.home.stateVersion = "22.05";
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
    ./mpd
    ./vimuwu
    ./schizofox
    inputs.hyprland.homeManagerModules.default
  ];
  config.modules = {
    programs = {
      schizofox = {
        enable = true;
        translate = {
          enable = true;
          sourceLang = "en";
          targetLang = "pl";
        };
      };
      vimuwu.enable = true;
    };
  };
}
