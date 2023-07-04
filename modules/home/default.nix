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
    inputs.anyrun.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModule
    ./packages.nix

    ./gtk
    ./git
    ./eww
    ./spotify
    ./foot
    ./anyrun
    ./rnnoise
    ./dunst
    ./bottom
    ./shell
    ./swaylock
    ./tools
    ./hyprland
    ./media
    ./zathura
    ./helix
  ];
}
