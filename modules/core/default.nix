{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bootloader.nix
    ./system.nix
    ./schizo.nix
    ./network.nix
    ./nix.nix
    ./users.nix
    ./openssh.nix
    ./blocker.nix
  ];
}
