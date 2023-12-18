{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system.nix
    ./schizo.nix
    ./bootloader.nix
    ./network.nix
    ./secrets.nix
    ./syncthing.nix
    ./impermanence.nix
    ./virtualisation.nix
    ./nix.nix
    ./users.nix
    ./cron.nix
    ./openssh.nix
    ./blocker.nix
  ];
}
