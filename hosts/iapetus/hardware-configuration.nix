{
  config,
  pkgs,
  lib,
  ...
}: let
  o = lib.mkOverride;
in {
  boot.loader.grub.enable = o false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # !!! Needed for the virtual console to work on the RPi 3, as the default of 16M doesn't seem to be enough.
  # If X.org behaves weirdly (I only saw the cursor) then try increasing this to 256M.
  # On a Raspberry Pi 4 with 4 GB, you should either disable this parameter or increase to at least 64M if you want the USB ports to work.
  boot = {
    kernelParams = ["cma=32M"];
    # workaround for issues with the bootloader
    kernelPackages = o pkgs.linuxPackages_5_4;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };
}
