{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  nvidia = ../modules/nvidia;
  wayland = ../modules/wayland;
  server = ../modules/server;
  hw = inputs.nixos-hardware.nixosModules;
  ragenix = inputs.ragenix.nixosModules.age;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [core ragenix];

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
  # all my hosts are named after saturn moons btw

  # desktop
  anthe = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "anthe";}
        ./anthe/hardware-configuration.nix
        bootloader
        nvidia
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # framework laptop
  # note that i dont actually have a framework laptop so i have no idea
  # if this configuration works
  io = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "anthe";}
        ./io/hardware-configuration.nix
        bootloader
        hw.framework
        nvidia
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # server
  iapetus = nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules =
      [
        hw.raspberry-pi-4
        ./iapetus
        server
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}
