{inputs, ...}:
# glue all configs together
{
  config.home.stateVersion = "22.05";
  imports = [
    inputs.nix-index-db.hmModules.nix-index
    # inputs.niri.homeModules.niri
    inputs.schizofox.homeManagerModule
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./packages.nix
    ./impermanence.nix

    ./scripts
    ./misc
  ];
}
