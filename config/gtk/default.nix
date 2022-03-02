{ pkgs, config, fetchzip, ... }:
{
  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

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
      name = "Source Sans 3";
      size = 13;
    };
  };
}
