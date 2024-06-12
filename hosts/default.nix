{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  core = ../system/core;
  bootloader = ../system/core/bootloader.nix;
  impermanence = ../system/core/impermanence.nix;
  server = ../system/server;
  wayland = ../system/wayland;
  hw = inputs.nixos-hardware.nixosModules;
  agenix = inputs.agenix.nixosModules.age;
  disko = inputs.disko.nixosModules.default;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [core agenix disko];

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
        {
          networking.hostName = "prometheus";
          boot.loader.grub.devices = ["/dev/sda"];
        }
        server
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
        ./iapetus
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}
