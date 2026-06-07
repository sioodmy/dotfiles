{
  pkgs,
  theme,
  lib,
  ...
}:
let
  inherit (builtins) toString isBool;
  inherit (lib) boolToString escape generators;

  toGtk3Ini = generators.toINI {
    mkKeyValue =
      key: value:
      let
        value' = if isBool value then boolToString value else toString value;
      in
      "${escape [ "=" ] key}=${value'}";
  };

  themepkg = pkgs.catppuccin-gtk.override {
        size = "compact";
        accents = ["mauve"];
        variant = "macchiato";
      };
in
{
  homix =
    let
      gtkINI = {
        gtk-theme-name = "Catppuccin-Macchiato-Compact-Mauve-dark";
        gtk-font-name = "Lexend 11";
        gtk-icon-theme-name = "Papirus-Dark";
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
        gtk-cursor-theme-name = "Bibata-Modern-Classic";
      };
      cssPath =
        gtkVersion:
        let
          version = toString gtkVersion;
          css34 = "/share/themes/catppuccin-macchiato-mauve-compact/gtk-${version}.0/gtk-dark.css";
        in
        {
          # "2" = "/share/themes/catppuccin-macchiato-mauve-compact/gtk-2.0/gtkrc";o-mauve-compact/gtk-2.0/gtkrc";
          "3" = css34;
          "4" = css34;
        }
        .${version};
      css = gtkVersion: ''
        @import url("file://${themepkg}${cssPath gtkVersion}");
      '';
    in
    {
      ".config/gtk-3.0/settings.ini".text = toGtk3Ini {
        Settings = gtkINI // {
          gtk-application-prefer-dark-theme = 1;
        };
      };
      ".config/gtk-4.0/settings.ini".text = toGtk3Ini {
        Settings = gtkINI;
      };
      ".config/gtk-3.0/gtk.css".text = css 3;
      ".config/gtk-4.0/gtk.css".text = css 4;
    };

  environment = {
    systemPackages = [
      pkgs.bibata-cursors
      pkgs.everforest-gtk-theme
      pkgs.papirus-icon-theme

    ];
    variables = {
      GSK_RENDERER = "gl";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      DISABLE_QT_COMPAT = "0";
      GTK_THEME =  "Catppuccin-Macchiato-Compact-Mauve-dark";

      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = 24;
    };
  };
}
