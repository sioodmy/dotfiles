{ pkgs, lib, config, fetchzip, ... }:
with lib;
let cfg = config.modules.desktop.gtk;
in {
  options.modules.desktop.gtk = { enable = mkEnableOption "gtk"; };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-green-dark-compact";
        package = pkgs.catppuccin-gtk;
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
