{
  config,
  pkgs,
  ...
}: {
  services = {
    dbus = {
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };
    udev.packages = with pkgs; [gnome.gnome-settings-daemon];
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
    (writeScriptBin "sudo" ''exec doas "$@"'')
  ];

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "pl";
}
