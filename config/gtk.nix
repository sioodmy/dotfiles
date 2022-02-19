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
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
}
