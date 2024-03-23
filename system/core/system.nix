{
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
    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';
  };

  # compress half of the ram to use as swap
  zramSwap = {
    enable = lib.mkDefault false;
    algorithm = "zstd";
  };

  environment.variables = {
    EDITOR = "hx";
    BROWSER = "schizofox";
  };
  environment.systemPackages = with pkgs; [
    git
    uutils-coreutils-noprefix
    btrfs-progs
    cifs-utils
    appimage-run
    starship # having starship here means pkgs.startship will be stored during build and not during promptInit
  ];

  time = {
    timeZone = "Europe/Warsaw";
    hardwareClockInLocalTime = true;
  };
  hardware.ledger.enable = true;

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
  console = let
    variant = "u24n";
  in {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-${variant}.psf.gz";
    earlySetup = true;
    keyMap = "pl";
  };

  boot.binfmt.registrations = lib.genAttrs ["appimage" "AppImage"] (ext: {
    recognitionType = "extension";
    magicOrExtension = ext;
    interpreter = "/run/current-system/sw/bin/appimage-run";
  });

  programs.nix-ld.enable = true;
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
    # Systemd OOMd
    # Fedora enables these options by default. See the 10-oomd-* files here:
    # https://src.fedoraproject.org/rpms/systemd/tree/acb90c49c42276b06375a66c73673ac3510255
    oomd.enableRootSlice = true;

    # TODO channels-to-flakes
    tmpfiles.rules = [
      "D /nix/var/nix/profiles/per-user/root 755 root root - -"
    ];
  };

  programs = {
    # allow users to mount fuse filesystems with allow_other
    fuse.userAllowOther = true;

    # help manage android devices via command line
    adb.enable = true;

    # "saying java is good because it runs on all systems is like saying
    # anal sex is good because it works on all species"
    # - sun tzu
    java = {
      enable = true;
      package = pkgs.jre;
    };
  };
}
