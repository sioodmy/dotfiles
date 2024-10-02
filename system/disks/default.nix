{...}: {
  # I know that this part will make some people mad

  # My configuraton is designed to be used only on desktops and laptops
  # therefore I use same partition layout for all of my hosts
  # I don't like mixing desktop and server configrations in a single flake

  staypls = {
    enable = true;
    dirs = ["/etc/ssh" "/etc/NetworkManager" "/etc/nix" "/var/lib/fprint" "/var/lib/pipewire"];
  };

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-label/NIXCRYPT";
    preLVM = true;
    allowDiscards = true;
  };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = ["size=8G" "mode=755"];
  };

  fileSystems."/nix" = {
    neededForBoot = true;
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=@nix" "compress=zstd"];
  };

  fileSystems."/persist" = {
    neededForBoot = true;
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=@persist" "compress=zstd"];
  };

  fileSystems."/home" = {
    neededForBoot = true;
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=@home" "compress=zstd"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
    options = ["noatime" "discard"];
  };

  #  btrfs filesystem mkswapfile --size 16g --uuid clear /persist/swap
  swapDevices = [
    {
      device = "/persist/swap";
    }
  ];
}
