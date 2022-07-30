{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # sudo cryptsetup config /dev/sda2 --label cryptroot
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-label/cryptroot";
    preLVM = true;
    allowDiscards = true;
  };

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" "acpi" "acpi-call" ];
  boot.kernelModules = [ "tpm-rng" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  boot.extraModprobeConfig = lib.mkDefault ''
    options bbswitch use_acpi_to_detect_card_state=1
  '';

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
