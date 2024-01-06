{...}: {
  imports = [
    ./system.nix
    ./schizo.nix
    ./network.nix
    ./secrets.nix
    ./nix.nix
    ./users.nix
    ./openssh.nix
  ];
}
