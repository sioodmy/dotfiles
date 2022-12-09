{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system.nix
    ./schizo.nix
    ./network.nix
    ./nix.nix
    ./users.nix
    ./cron.nix
    ./openssh.nix
    ./blocker.nix
  ];
}
