{lib, ...}: let
  inherit (lib) forEach;
in {
  home.persistence."/persist/home/sioodmy" = {
    allowOther = true;
    directories =
      [
        "download"
        "music"
        "dev"
        "docs"
        "pics"
        "vids"
        "other"
      ]
      ++ forEach ["syncthing" "Caprine" "chromium" "VencordDesktop" "obs-studio" "Signal"] (
        x: ".config/${x}"
      )
      ++ forEach ["tealdeer" "keepassxc" "nix" "chromium" "starship" "nix-index"] (
        x: ".cache/${x}"
      )
      ++ forEach ["direnv" "TelegramDesktop" "PrismLauncher" "keyrings"] (x: ".local/share/${x}")
      ++ [".ssh" ".keepass"];
  };
}
