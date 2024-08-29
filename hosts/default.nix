{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  core = ../system/core;
  bootloader = ../system/core/bootloader.nix;
  impermanence = ../system/core/impermanence.nix;
  wayland = ../system/wayland;
  hw = inputs.nixos-hardware.nixosModules;

  shared = [core];
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
}
