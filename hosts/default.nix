{
  nixpkgs,
  self,
  ...
}: let
  inputs = self.inputs;
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  nvidia = ../modules/nvidia;
  wayland = ../modules/wayland;
  server = ../modules/server;
  hw = inputs.nixos-hardware.nixosModules;

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
  # all my hosts are named after saturn moons btw

  # desktop
  anthe = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "anthe";}
      ./anthe/hardware-configuration.nix
      core
      bootloader
      server
      nvidia
      wayland
      hmModule
      {inherit home-manager;}
    ];
    specialArgs = {inherit inputs;};
  };

  # laptop
  io = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {networking.hostName = "anthe";}
      ./io/hardware-configuration.nix
      core
      bootloader
      nvidia
      wayland
      hmModule
      {inherit home-manager;}
    ];
    specialArgs = {inherit inputs;};
  };

  # server
  iapetus = nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = [
      hw.raspberry-pi-4
      ./iapetus
      core
      server
    ];
    specialArgs = {inherit inputs;};
  };
}
