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

    ./qt
    ./git
    ./foot
    ./dunst
    ./tofi
    ./bottom
    ./shell
    ./swaylock
    ./tools
    ./waybar
    ./newsboat
    ./hyprland
    ./media
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
