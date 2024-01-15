{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  core = ../system/core;
  bootloader = ../system/core/bootloader.nix;
  impermanence = ../system/core/impermanence.nix;
  nvidia = ../system/nvidia;
  server = ../system/server;
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
    users.sioodmy = {
      imports = [../home];

      _module.args.theme = import ../theme;
    };
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
        bootloader
        impermanence
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
        bootloader
        impermanence
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
        bootloader
        ./prometheus
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  iapetus = nixpkgs.lib.nixosSystem {
    system = "aarch64";
    modules =
      [
        {networking.hostName = "iapetus";}
        hw.raspberry-pi-4
        server
        inputs.schizosearch.nixosModules.default
        ./iapetus
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}
