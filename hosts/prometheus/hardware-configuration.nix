{
  modulesPath,
  lib,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];


  boot.initrd.availableKernelModules =
    [
      "ata_piix"
      "virtio_pci"
      "virtio_scsi"
      "xhci_pci"
      "sd_mod"
      "sr_mod"
    ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  swapDevices = [];
  nixpkgs.hostPlatform = lib.mkdefault "x86_64-linux";

}
