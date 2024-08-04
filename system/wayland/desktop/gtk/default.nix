{
  lib,
  config,
  pkgs,
  ...
}: let
  colors = config.colorScheme.palette;

  toGtk3Ini = with lib;
    generators.toINI {
      mkKeyValue = key: value: let
        value' =
          if isBool value
          then boolToString value
          else toString value;
      in "${escape ["="] key}=${value'}";
    };
in {
  homix = let
    css = import ./colors.nix {inherit colors;};
    gtkINI = {
      gtk-application-prefer-dark-theme = 1;
      gtk-font-name = "Lexend 11";
      gtk-icon-theme-name = "Papirus";
      gtk-theme-name = "adw-gtk3";
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
  in {
    ".config/gtk-3.0/gtk.css".text = css;
    ".config/gtk-4.0/gtk.css".text = css;
    ".config/gtk-3.0/settings.ini".text = toGtk3Ini {
      Settings = gtkINI;
    };
    ".config/gtk-4.0/settings.ini".text = toGtk3Ini {
      Settings =
        gtkINI
        // {
          gtk-application-prefer-dark-theme = 1;
        };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      catppuccin-papirus-folders
      bibata-cursors
      adw-gtk3
      lexend
    ];
    variables = {
      GTK_THEME = "adw-gtk3";
    };
  };
}
