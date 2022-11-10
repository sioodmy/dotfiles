{
  nixpkgs,
  self,
  ...
}: let
  inputs = self.inputs;
  core = ../modules/core;
  nvidia = ../modules/nvidia;
  wayland = ../modules/wayland;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.sioodmy = ../modules/home;
  };
in {
  anthe = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "anthe";}
      ./anthe/hardware-configuration.nix
      core
      nvidia
      wayland
      hmModule
      {inherit home-manager;}
    ];
    specialArgs = {inherit inputs;};
  };

  io = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "anthe";}
      ./io/hardware-configuration.nix
      core
      nvidia
      wayland
      hmModule
      {inherit home-manager;}
    ];
    specialArgs = {inherit inputs;};
  };
}
