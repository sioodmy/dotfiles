{
  modulesPath,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6A3B-1D00";
    fsType = "vfat";
    options = [
      "noatime"
      "discard"
    ];
  };
  imports = [
    inputs.apple-silicon-support.nixosModules.apple-silicon-support

    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.asahi = {
    enable = true;
    extractPeripheralFirmware = true;
    peripheralFirmwareDirectory = ./firmware;
    setupAsahiSound = true;
  };

  # systemd.packages = [ pkgs.speakersafetyd ];
  # services.udev.packages = [ pkgs.speakersafetyd ];

  services.upower.enable = true;

  environment = {
    systemPackages = lib.attrValues {
      inherit (pkgs)
       asahi-audio
      asahi-bless
      asahi-fwextract
      ;
      
    };
  };
  hardware.graphics.enable32Bit = lib.mkForce false;
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    # This refers to the uncompressed size, actual memory usage will be lower.
    memoryPercent = 50;
  };

  boot = {
    # https://rdx.overdevs.com/comments.html?url=https://www.reddit.com/r/AsahiLinux/comments/1gy0t86/psa_transitioning_from_zramswap_to_zswap/
    kernelParams = [
      "zswap.zpool=zsmalloc"
    ];
    binfmt.emulatedSystems = [ "x86_64-linux" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = lib.mkForce false;
    };

    initrd.availableKernelModules = [
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [
      "usbhid"
      "dm-snapshot"
    ];
  };
}
