{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  core = ../system/core;
  nvidia = ../system/nvidia;
  wayland = ../system/wayland;
  hw = inputs.nixos-hardware.nixosModules;
  agenix = inputs.agenix.nixosModules.age;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [core agenix];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.sioodmy = ../home;
  };
in {
  # all my hosts are named after saturn moons btw

  # desktop
  anthe = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "anthe";}
        ./anthe
        nvidia
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # thinkpad
  calypso = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "calypso";}
        ./calypso
        wayland
        hmModule
        hw.lenovo-thinkpad-x1-7th-gen
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # x86 home server
  prometheus = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "prometheus";}
        ./prometheus
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}
