{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.gpg;
in {
  options.modules.cli.gpg = { enable = mkEnableOption "gpg"; };

  config = mkIf cfg.enable {
    programs.gpg = { enable = true; };

    programs.password-store = { enable = true; };

    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "gtk2";
    };

    programs.rofi.pass = { enable = true; };
  };
}
