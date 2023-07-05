{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.impermanence.nixosModule];
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = ["/etc/nixos" "/etc/NetworkManager" "/var/log" "/var/lib" "/etc/nix" "/etc/ssh" "/var/db/sudo"];
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
        ".cache/starship"
        ".local/share/nheko"
        ".config/nheko"
        ".cache/nix-index"
        ".config/obs-studio"
      ];
    };
  };
}
