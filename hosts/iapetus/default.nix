{
  lib,
  pkgs,
  ...
}: {
  networking = {
    hostName = "iapetus";
  };

  # use bash on the server
  users.users = {
    sioodmy = {
      isNormalUser = true;
      shell = pkgs.bash;
      extraGroups = [
        "wheel"
        "gitea"
        "docker"
        "systemd-journal"
        "vboxusers"
        "audio"
        "plugdev"
        "wireshark"
        "video"
        "input"
        "lp"
        "networkmanager"
        "power"
        "nix"
        "adbusers"
      ];
      uid = 1000;
      initialHashedPassword = "$y$j9T$OMptZfwbCi8wXqWho2Eca0$V7GNYVR6BFb0YHFBwSdJNGuGeLLv2R5zNWC/NL/R6aA";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9ExEl6WqtCI4yCqbSAhAGmzvVp/nYADbgy/Qi4AKQy sioodmy@anthe"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+S9LPxp3Mmha1keHlwc0iVq4CMbHvzAAwuYE2go7io sioodmy@calypso"
      ];
    };
    root.
        openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9ExEl6WqtCI4yCqbSAhAGmzvVp/nYADbgy/Qi4AKQy sioodmy@anthe"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+S9LPxp3Mmha1keHlwc0iVq4CMbHvzAAwuYE2go7io sioodmy@calypso"
    ];
  };

  # this is actually quite useful on servers
  systemd.services.NetworkManager-wait-online.enable = lib.mkOverride 900 true;

  nixpkgs.localSystem.system = "aarch64-linux";
  nixpkgs.crossSystem.system = "aarch64-linux";

  boot = {
    # Use mainline kernel, vendor kernel has some issues compiling due to
    # missing modules that shouldn't even be in the closure.
    # https://github.com/NixOS/nixpkgs/issues/111683
    kernelPackages = pkgs.linuxPackages_rpi4;
    kernelModules = lib.mkForce ["bridge" "macvlan" "tap" "tun" "loop" "atkbd" "ctr"];
    supportedFilesystems = lib.mkForce ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" "ext4" "vfat"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };
  system.stateVersion = "22.05"; # DONT TOUCH THIS
}
