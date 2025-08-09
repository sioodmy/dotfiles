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
      gtk-theme-name = "Nordic";
      gtk-application-prefer-dark-theme = 1;
      gtk-font-name = "Lexend 11";
      gtk-icon-theme-name = "Papirus";
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
    ".config/gtk-4.0/settings.ini".text = toGtk3Ini {
      Settings = gtkINI;
      AdwStyleManager = {
        color-scheme = "ADW_COLOR_SCHEME_PREFER_DARK";
      };
    };
    ".config/gtk-4.0/gtk.css".text = ''
      /**
       * GTK 4 reads the theme configured by gtk-theme-name, but ignores it.
       * It does however respect user CSS, so import the theme from here.
      **/
      @import url("file://${themepkg}/share/themes/Nordic/gtk-4.0/gtk.css");
    '';
  };

  environment = {
    systemPackages = [
      pkgs.bibata-cursors
      pkgs.nordic
      pkgs.adw-gtk3
      pkgs.papirus-icon-theme
    ];
    variables =  {
      GTK_THEME = "Nordic";
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
