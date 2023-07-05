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
    ./nix.nix
    ./users.nix
    ./cron.nix
    ./openssh.nix
    ./blocker.nix
  ];
}
