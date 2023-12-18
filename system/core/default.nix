{...}: {
  imports = [
    ./system.nix
    ./schizo.nix
    ./bootloader.nix
    ./network.nix
    ./secrets.nix
    ./syncthing.nix
    ./impermanence.nix
    ./nix.nix
    ./users.nix
    ./openssh.nix
  ];
}
