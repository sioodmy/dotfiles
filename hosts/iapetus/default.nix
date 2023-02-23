{
  config,
  lib,
  pkgs,
  ...
}: {
  networking = {
    hostName = "iapetus";
  };

  # use bash on the server
  users.users.sioodmy.shell = lib.mkOverride 900 pkgs.bash;

  # this is actually quite useful on servers
  systemd.services.NetworkManager-wait-online.enable = lib.mkOverride 900 true;

  nixpkgs.localSystem.system = "aarch64-linux";

  boot = {
    # Use mainline kernel, vendor kernel has some issues compiling due to
    # missing modules that shouldn't even be in the closure.
    # https://github.com/NixOS/nixpkgs/issues/111683
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = lib.mkForce ["bridge" "macvlan" "tap" "tun" "loop" "atkbd" "ctr"];
    supportedFilesystems = lib.mkForce ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" "ext4" "vfat"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };
}
