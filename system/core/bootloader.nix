{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
in {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];
  boot = {
    binfmt.emulatedSystems = ["aarch64-linux" "riscv64-linux"];
    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
    };
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    kernelPackages = mkDefault pkgs.linuxPackages_latest;

    bootspec.enable = mkDefault true;
    loader = {
      systemd-boot = {
        enable = mkDefault true;
        memtest86.enable = true;
        configurationLimit = 10;
        editor = false;
      };
      # spam space to get to boot menu
      timeout = 0;
    };
    loader.efi.canTouchEfiVariables = true;
  };
}
