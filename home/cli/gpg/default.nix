{ pkgs, config, ...}:

{
  programs.gpg = {
    enable = true;
  };

  programs.password-store = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gtk2";
  };

  programs.rofi.pass = {
    enable = true;
  };
}
