{
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];
  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    tmp = {
      cleanOnBoot = true;
      useTmpfs = false;
    };
    # some kernel parameters, i dont remember what half of this shit does but who cares
    initrd.verbose = false;
    kernelPackages = mkDefault pkgs.linuxPackages_latest;

    bootspec.enable = mkDefault true;
    loader = {
      systemd-boot.enable = mkDefault true;
      # spam space to get to boot menu
      timeout = 0;
    };
    loader.efi.canTouchEfiVariables = true;
  };
}
