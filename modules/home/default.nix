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
  config.home.extraOutputsToInstall = ["doc" "devdoc"];
  imports = [
    ./packages.nix

    ./gtk
    ./git
    ./foot
    ./dunst
    ./rofi
    ./bottom
    ./shell
    ./swaylock
    ./tools
    ./waybar
    ./newsboat
    ./hyprland
    ./mpd
    ./zathura
    ./helix
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
    };
  };
}
