{...}: {
  imports = [
    ./system.nix
    ./schizo.nix
    ./network.nix
    ./nix.nix
    ./users.nix
    ./git.nix
    ./openssh.nix
    ./devpkgs.nix
    ./syncthing.nix
  ];
}
