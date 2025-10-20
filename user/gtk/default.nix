{
  pkgs,
  theme,
  lib,
  ...
}: let
  inherit (builtins) toString isBool;
  inherit (lib) boolToString escape generators;

  toGtk3Ini = generators.toINI {
    mkKeyValue = key: value: let
      value' =
        if isBool value
        then boolToString value
        else toString value;
    in "${escape ["="] key}=${value'}";
  };
  themepkg = pkgs.nordic;
in {
  homix = let
    gtkINI = {
      gtk-font-name = "Lexend 11";
      # gtk-icon-theme-name = "Papirus-Dark";
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-cursor-theme-name = "Bibata-Modern-Classic";
    };
  in {
    ".config/gtk-3.0/settings.ini".text = toGtk3Ini {
      Settings =
        gtkINI
        // {
          gtk-application-prefer-dark-theme = 1;
        };
    };
  };

  environment = {
    systemPackages = [
      pkgs.bibata-cursors
      pkgs.adw-gtk3
      pkgs.papirus-icon-theme
    ];
    variables =  {
      GSK_RENDERER = "gl";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      DISABLE_QT_COMPAT = "0";

      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = 24;
    };
  };
}
