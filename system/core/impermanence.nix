{
  inputs,
  lib,
  ...
}: let
  inherit (lib) forEach;
in {
  imports = [inputs.impermanence.nixosModule];
  fileSystems."/etc/ssh" = {
    depends = ["/persist"];
    neededForBoot = true;
  };
  environment.persistence."/persist" = {
    hideMounts = true;
    directories =
      # persist directories in user directory (stolen from n3oney)
      builtins.map (v: {
        directory = "/home/sioodmy/${v}";
        user = "sioodmy";
        group = "users";
      }) (
        [
          "download"
          "music"
          "dev"
          "docs"
          "pics"
          "vids"
          "other"
        ]
        ++ forEach ["syncthing" "obs-studio" "Signal" "niri" "BraveSoftware" "nicotine" "river" "emacs"] (
          x: ".config/${x}"
        )
        ++ forEach ["tealdeer" "keepassxc" "nix" "starship" "nix-index" "librewolf" "go-build" "BraveSoftware" "zsh" "nvim"] (
          x: ".cache/${x}"
        )
        ++ forEach ["direnv" "TelegramDesktop" "PrismLauncher" "keyrings" "nicotine" "zoxide"] (x: ".local/share/${x}")
        ++ [".ssh" ".keepass" ".librewolf"]
      )
      ++ [
        # dirty fix for "no storage left on device" while rebuilding
        # it gets wiped anyway
        "/tmp"
        "/var/log"
        "/var/db/sudo"
      ]
      ++ forEach ["nixos" "NetworkManager" "nix" "ssh" "secureboot"] (x: "/etc/${x}")
      ++ forEach ["bluetooth" "nixos" "pipewire" "libvirt" "fail2ban" "fprint"] (x: "/var/lib/${x}");
    files = ["/etc/machine-id"];
  };
  # for some reason *this* is what makes networkmanager not get screwed completely instead of the impermanence module
  systemd.tmpfiles.rules = [
    "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
    "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
    "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
  ];
}
