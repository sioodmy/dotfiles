{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.impermanence.nixosModule];
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
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
    users.sioodmy = {
      files = [".database.kdbx"];
      directories = [
        "download"
        "music"
        "dev"
        "docs"
        "vids"
        "other"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".nixops";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ".steam"
        ".local/share/Steamd"
        ".local/share/direnv"
        ".local/share/zoxide"
        ".local/share/PrismLauncher"
        ".local/share/TelegramDesktop"
        ".config/Caprine"
        ".config/WebCord"
        ".config/BraveSoftware/"
        ".cache/BraveSoftware/"
        ".cache/spotify"
        ".cache/starship"
        ".local/share/nheko"
        ".config/nheko"
        ".cache/nix-index"
        ".config/obs-studio"
      ];
    };
  };
  # for some reason *this* is what makes networkmanager not get screwed completely instead of the impermanence module
  systemd.tmpfiles.rules = [
    "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
    "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
    "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
  ];
}
