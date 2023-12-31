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
    binfmt.emulatedSystems = ["aarch64-linux"];
    tmp = {
      cleanOnBoot = true;
      useTmpfs = false;
    };
    # some kernel parameters, i dont remember what half of this shit does but who cares
    consoleLogLevel = mkDefault 0;
    initrd.verbose = false;
    # switch from old ass lts kernel
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
    extraModprobeConfig = "options hid_apple fnmode=1";

    bootspec.enable = mkDefault true;
    loader = {
      systemd-boot.enable = mkDefault true;
      timeout = 0;
    };
    loader.efi.canTouchEfiVariables = true;
  };
}
