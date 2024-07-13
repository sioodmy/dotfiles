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
      ++ forEach ["syncthing" "Caprine" "VencordDesktop" "obs-studio" "Signal" "niri" "BraveSoftware" "nicotine" "ags" "nushell" "emacs"] (
        x: ".config/${x}"
      )
      ++ forEach ["tealdeer" "keepassxc" "nix" "starship" "nix-index" "mozilla" "go-build" "BraveSoftware" "zsh" "nvim"] (
        x: ".cache/${x}"
      )
      ++ forEach ["direnv" "TelegramDesktop" "PrismLauncher" "keyrings" "nicotine" "zoxide"] (x: ".local/share/${x}")
      ++ [".ssh" ".keepass" ".mozilla" ".thunderbird"];
  };
}
