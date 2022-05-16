{ pkgs, lib, config, fetchzip, ... }:
with lib;
let cfg = config.modules.desktop.gtk;
in {
  options.modules.desktop.gtk = { enable = mkEnableOption "gtk"; };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Nordic";
        package = pkgs.nordic;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      font = {
        name = "Inter";
        size = 12;
      };
    };
  };
}
