{
  lib,
  pkgs,
  ...
}: {
  services.openssh.enable = true;
  services.fail2ban = {
    enable = true;
    maxretry = 3;
    ignoreIP = [
      "127.0.0.0/8"
      "10.0.0.0/8"
      "192.168.0.0/16"
    ];
  };
  networking = {
    hostName = "iapetus";
    defaultGateway = "192.168.21.1";
    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.21.69";
        prefixLength = 24;
      }
    ];
  };

  nixpkgs.overlays = [
    (self: super: let
      # I hate cross compilation
      dummy = pkgs.runCommandNoCC "neutered-firmware" {} "mkdir -p $out/lib/firmware";
    in {
      alsa-firmware = dummy;
      crda = dummy;
      # Regression caused by including a new package in the closure
      # Added in f1922cdbdc608b1f1f85a1d80310b54e89d0e9f3
      smartmontools = super.smartmontools.overrideAttrs (old: {
        configureFlags = [];
      });
    })
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  # nixpkgs.localSystem.system = "aarch64-linux";
  # nixpkgs.crossSystem.system = "aarch64-linux";

  boot = {
    # Use mainline kernel, vendor kernel has some issues compiling due to
    # missing modules that shouldn't even be in the closure.
    # https://github.com/NixOS/nixpkgs/issues/111683
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
    kernelModules = lib.mkForce ["bridge" "macvlan" "tap" "tun" "loop" "atkbd" "ctr"];
    supportedFilesystems = lib.mkForce ["btrfs" "ext4" "vfat"];
  };

  # `xterm` is being included even though this is GUI-less.
  # → https://github.com/NixOS/nixpkgs/pull/62852
  services.xserver.desktopManager.xterm.enable = lib.mkForce false;

  # fails to build
  security.polkit.enable = lib.mkForce false;

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };
  system.stateVersion = "22.05"; # DONT TOUCH THIS
}
