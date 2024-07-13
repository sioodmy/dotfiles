{...}: {
  imports = [
    ./system.nix
    ./schizo.nix
    ./network.nix
    ./secrets.nix
    ./nix.nix
    ./users.nix
    ./git.nix
    ./openssh.nix
    ./syncthing.nix
  ];
}
