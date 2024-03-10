{
  inputs,
  config,
  ...
}:
# glue all configs together
{
  config.home.stateVersion = "22.05";
  config.home.extraOutputsToInstall = ["doc" "devdoc"];
  imports = [
    inputs.nix-index-db.hmModules.nix-index
    inputs.barbie.homeManagerModule
    inputs.schizofox.homeManagerModule
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.hyprlock.homeManagerModules.default
    inputs.hypridle.homeManagerModules.default
    ./packages.nix
    ./impermanence.nix

    ./cli
    ./scripts
    ./rice
    ./misc
  ];
}
