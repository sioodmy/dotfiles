{
  description = "Consequence of allowing autistic people on the internet. Stay mad one-proper-config-structure purists :3";

  outputs = {nixpkgs, ...} @ inputs: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    theme = import ./theme;
    user = import ./user {
      inherit pkgs theme;
    };
  in {
    nixosConfigurations = import ./hosts inputs;
    nixosModules =
      {
        # This module is not meant to be imported by anyone but me
        # it's just so I can easily avoid ../../../../../ mess
        system = import ./system;

        user = user.module;

        # place for my home brew modules
      }
      // import ./modules;

    inherit theme;
    packages.x86_64-linux = user.packages;
    formatter.x86_64-linux = pkgs.alejandra;
    devShells.x86_64-linux.default = user.shell;
  };

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
}
