{ config, lib, inputs, ... }:

{
  
  imports = [inputs.impermanence.nixosModule];
   environment.persistence."/persist" = {
    hideMounts = true;
    directories = ["/etc/nixos" "/etc/NetworkManager" "/var/log" "/var/lib" "/etc/nix" "/etc/ssh" "/var/db/sudo"];
    # files = ["/etc/machine-id"];
    users.sioodmy= {
      directories = [
        "download"
        "music"
        "dev"
        "docs"
        "vids"
        "other"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".nixops"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        ".local/share/direnv"
        ".local/share/PrismLauncher"
        ".local/share/TelegramDesktop"
        ".config/Caprine"
        ".config/WebCord"
        ".cache/starship"
        ".local/share/nheko"
        ".config/nheko"
        ".cache/nix-index"
        ".config/obs-studio"
      ];
    };
  };
}