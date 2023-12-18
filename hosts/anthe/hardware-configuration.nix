{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  fileSystems."/etc/ssh" = {
    depends = ["/persist"];
    neededForBoot = true;
  };

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-label/NIXCRYPT";
    preLVM = true;
    allowDiscards = true;
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
    device = "none";
    fsType = "tmpfs";
    options = ["size=8G" "mode=755"];
  };

  fileSystems."/persist" = {
    neededForBoot = true;
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=@persist" "compress=zstd"];
  };

  fileSystems."/nix" = {
    neededForBoot = true;
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=@nix" "compress=zstd"];
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
