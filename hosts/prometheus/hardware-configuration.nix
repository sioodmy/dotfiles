{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  fileSystems."/etc/ssh" = {
    depends = ["/persist"];
    neededForBoot = true;
  };

  boot.initrd.availableKernelModules =
    [
      "xhci_pci"
      "ahci"
      "usbhid"
      "sd_mod"
      "dm_mod"
      "dm_crypt"
      "cryptd"
      "input_leds"
    ]
    ++ config.boot.initrd.luks.cryptoModules;
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    neededForBoot = true;
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = ["noatime" "discard" "compress=zstd"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
    options = ["noatime" "discard"];
  };

  swapDevices = [{device = "/dev/disk/by-label/swap";}];

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
