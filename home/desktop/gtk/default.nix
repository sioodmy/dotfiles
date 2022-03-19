{ pkgs, config, fetchzip, ... }:

{
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
}
