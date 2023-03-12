{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    dbus = {
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };
    udev.packages = with pkgs; [gnome.gnome-settings-daemon android-udev-rules];
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
    udisks2.enable = true;
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';
  };

  # compresses half the ram for use as swap
  zramSwap.enable = true;

  environment.variables = {
    EDITOR = "hx";
    BROWSER = "firefox";
  };
  environment.systemPackages = with pkgs; [
    git
    steam-run
    appimage-run
    (writeScriptBin "sudo" ''exec doas "$@"'')
  ];

  time.timeZone = "Europe/Warsaw";
  i18n = let
    defaultLocale = "en_US.UTF-8";
    pl = "pl_PL.UTF-8";
  in {
    inherit defaultLocale;
    extraLocaleSettings = {
      LANG = defaultLocale;
      LC_COLLATE = defaultLocale;
      LC_CTYPE = defaultLocale;
      LC_MESSAGES = defaultLocale;

      LC_ADDRESS = pl;
      LC_IDENTIFICATION = pl;
      LC_MEASUREMENT = pl;
      LC_MONETARY = pl;
      LC_NAME = pl;
      LC_NUMERIC = pl;
      LC_PAPER = pl;
      LC_TELEPHONE = pl;
      LC_TIME = pl;
    };
  };
  console.keyMap = "pl";

  boot.binfmt.registrations = lib.genAttrs ["appimage" "AppImage"] (ext: {
    recognitionType = "extension";
    magicOrExtension = ext;
    interpreter = "/run/current-system/sw/bin/appimage-run";
  });

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      openssl
      curl
      glib
      util-linux
      glibc
      icu
      libunwind
      libuuid
      zlib
      libsecret
      # graphical
      freetype
      libglvnd
      libnotify
      SDL2
      vulkan-loader
      gdk-pixbuf
      xorg.libX11
    ];
  };
  systemd = let
    extraConfig = ''
      DefaultTimeoutStopSec=15s
    '';
  in {
    inherit extraConfig;
    user = {inherit extraConfig;};
    services."getty@tty1".enable = false;
    services."autovt@tty1".enable = false;
    services."getty@tty7".enable = false;
    services."autovt@tty7".enable = false;

    # TODO channels-to-flakes
    tmpfiles.rules = [
      "D /nix/var/nix/profiles/per-user/root 755 root root - -"
    ];
  };
}
