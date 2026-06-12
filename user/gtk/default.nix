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

  themeName = "catppuccin-macchiato-mauve-compact";

  themepkg = pkgs.catppuccin-gtk.override {
    size = "compact";
    accents = [ "mauve" ];
    variant = "macchiato";
  };

  kvantumThemeName = "catppuccin-macchiato-mauve";

  kvantumPkg = pkgs.catppuccin-kvantum.override {
    accent = "mauve";
    variant = "macchiato";
  };
in
{
  homix =
    let
      gtkINI = {
        gtk-theme-name = themeName;
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
          css34 = "/share/themes/${themeName}/gtk-${version}.0/gtk-dark.css";
        in
        {
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

      ".config/Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=${kvantumThemeName}
      '';

      ".config/qt5ct/qt5ct.conf".text = ''
        [Appearance]
        style=kvantum
        color_scheme_path=
        icon_theme=Papirus-Dark
      '';

      ".config/qt6ct/qt6ct.conf".text = ''
        [Appearance]
        style=kvantum
        color_scheme_path=
        icon_theme=Papirus-Dark
      '';
    };

  environment = {
    systemPackages = [
      themepkg
      kvantumPkg
      pkgs.libsForQt5.qt5ct
      pkgs.kdePackages.qt6ct
      pkgs.libsForQt5.qtstyleplugin-kvantum
      pkgs.kdePackages.qtstyleplugin-kvantum
      pkgs.bibata-cursors
      pkgs.papirus-icon-theme
    ];
    variables = {
      GSK_RENDERER = "gl";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_PLUGIN_PATH = "/run/current-system/sw/lib/qt-5.15.18/plugins:/run/current-system/sw/lib/qt-6/plugins";
      QT_STYLE_OVERRIDE = "kvantum";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      DISABLE_QT_COMPAT = "0";
      GTK_THEME = themeName;

      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = 24;
    };
  };
}
