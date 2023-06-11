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
    inputs.hyprland.homeManagerModules.default
    inputs.nix-index-db.hmModules.nix-index
    inputs.spicetify-nix.homeManagerModule
    ./packages.nix

    ./gtk
    ./git
    ./spotify
    ./foot
    ./anyrun
    ./rnnoise
    ./dunst
    ./bottom
    ./shell
    ./swaylock
    ./tools
    ./waybar
    ./hyprland
    ./media
    ./zathura
    ./helix
  ];
}
