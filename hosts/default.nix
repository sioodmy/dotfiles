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

  shared = [core agenix];
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
        bootloader
        impermanence
        hw.lenovo-thinkpad-x1-7th-gen
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
}
