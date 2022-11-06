{
  description = "My NixOS configuration";
  # https://github.com/sioodmy/dotfiles

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    hyprland.url = "github:hyprwm/Hyprland/";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

    mkSystem = pkgs: system: hostname:
      pkgs.lib.nixosSystem {
        system = system;
        modules = [
          {networking.hostName = hostname;}
          (./. + "/hosts/${hostname}/system.nix")
          (./. + "/hosts/${hostname}/hardware-configuration.nix")
          ./system
          inputs.hyprland.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {inherit inputs;};
              users.sioodmy = ./. + "/hosts/${hostname}/user.nix";
            };
            nixpkgs.overlays = [inputs.nixpkgs-wayland.overlay];
          }
        ];
        specialArgs = {inherit inputs;};
      };
  in {
    nixosConfigurations = {
      # https://wikiless.org/wiki/Moons_of_Saturn?lang=en
      anthe = mkSystem inputs.nixpkgs "x86_64-linux" "anthe";
      io = mkSystem inputs.nixpkgs "x86_64-linux" "io";
    };

    packages.${system} = {
      catppuccin-folders = pkgs.callPackage ./pkgs/catppuccin-folders.nix {};
      catppuccin-gtk = pkgs.callPackage ./pkgs/catppuccin-gtk.nix {};
      catppuccin-cursors = pkgs.callPackage ./pkgs/catppuccin-cursors.nix {};
      rofi-calc-wayland = pkgs.callPackage ./pkgs/rofi-calc-wayland.nix {};
      rofi-emoji-wayland = pkgs.callPackage ./pkgs/rofi-emoji-wayland.nix {};
    };

    devShells.${system}.default =
      pkgs.mkShell {packages = [pkgs.alejandra];};
  };
}
