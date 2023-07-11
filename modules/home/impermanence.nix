{ ...}: {
  home.persistence."/persist/home/sioodmy" = {
    allowOther = true;
    files = [".database.kdbx"];
    directories = [
      "download"
      "music"
      "dev"
      "docs"
      "vids"
      "other"
      {
        directory = ".local/share/zoxide";
        method = "symlink";
      }
      ".ssh"
      ".local/share/direnv"
      ".local/share/PrismLauncher"
      ".local/share/TelegramDesktop"
      ".local/share/keyrings"
      ".config/Caprine"
      ".cache/keepassxc"
      ".config/WebCord"
      ".config/easyeffects"
      ".config/BraveSoftware/"
      ".cache/BraveSoftware/"
      ".cache/thunderbird/"
      ".thunderbird"
      ".cache/spotify"
      ".cache/starship"
      ".local/share/nheko"
      ".cache/nheko"
      ".config/nheko"
      ".cache/nix-index"
      ".config/obs-studio"
    ];
  };
}
