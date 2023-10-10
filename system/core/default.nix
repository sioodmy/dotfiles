{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system.nix
    ./schizo.nix
    ./network.nix
    ./impermanence.nix
    ./virtualisation.nix
    ./nix.nix
    ./users.nix
    ./cron.nix
    ./openssh.nix
    ./blocker.nix
  ];
}
