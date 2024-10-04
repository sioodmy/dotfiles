{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  mkHost = name: system:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        {networking.hostName = name;}
        ./${name}
        self.nixosModules.system
        self.nixosModules.homix
        self.nixosModules.staypls
        self.nixosModules.user
        self.nixosModules.laptop
      ];

      # This allows to easily access flake inputs and outputs
      # from nixos modules, so it's a little bit cleaner
      specialArgs = {
        inherit inputs;
        theme = import ../theme;
        flake = self;
      };
    };
in {
  calypso = mkHost "calypso" "x86_64-linux";
}
