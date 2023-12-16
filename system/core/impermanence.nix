{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.impermanence.nixosModule];
  fileSystems."/etc/ssh" = {
    depends = ["/persist"];
    neededForBoot = true;
  };
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      # dirty fix for "no storage left on device" while rebuilding
      # it gets wiped anyway
      "/tmp"
      "/etc/nixos"
      "/etc/NetworkManager"
      "/var/log"
      "/var/lib"
      "/etc/nix"
      "/etc/ssh"
      "/var/db/sudo"
      "/etc/secureboot"

      "/etc/NetworkManager/system-connections"
      "/var/lib/flatpak"
      "/var/lib/libvirt"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/pipewire"
      "/var/lib/systemd/coredump"
      "/var/cache/tailscale"
      "/var/lib/tailscale"
    ];
    files = ["/etc/machine-id"];
  };
  # for some reason *this* is what makes networkmanager not get screwed completely instead of the impermanence module
  systemd.tmpfiles.rules = [
    "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
    "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
    "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
  ];
}
