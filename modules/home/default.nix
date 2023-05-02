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
    ./anyrun
    ./rnnoise
    ./dunst
    ./bottom
    ./shell
    ./pandoc
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
    inputs.nix-index-db.hmModules.nix-index
  ];
}
