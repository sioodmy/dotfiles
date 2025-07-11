{
  pkgs,
  theme,
  lib,
  ...
}: let
  inherit (builtins) toString isBool;
  inherit (lib) boolToString escape generators optionalAttrs;

  toGtk3Ini = generators.toINI {
    mkKeyValue = key: value: let
      value' =
        if isBool value
        then boolToString value
        else toString value;
    in "${escape ["="] key}=${value'}";
  };
  gtk-theme-name =
    if theme.gtk.enable
    then theme.gtk.name
    else "adw-gtk3-dark";
in {
  homix = let
    css = import ./colors.nix {inherit theme;};
    gtkINI = {
      inherit gtk-theme-name;
      gtk-application-prefer-dark-theme = 1;
      gtk-font-name = "Lexend 11";
      gtk-icon-theme-name = "Papirus";
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-cursor-theme-name = theme.cursor.x.name;
    };
  in
    {
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
    }
    // optionalAttrs theme.gtk.enable {
      ".config/gtk-3.0/gtk.css".text = css;
      ".config/gtk-4.0/gtk.css".text = css;
    };

  environment = {
    systemPackages = [
      theme.cursor.x.package
      (
        if theme.gtk.enable
        then theme.gtk.package
        else pkgs.adw-gtk3
      )
      pkgs.adw-gtk3
      pkgs.papirus-icon-theme
    ];
    variables = let
      cursorSize = 24;
    in {
      GTK_THEME = gtk-theme-name;
      GSK_RENDERER="gl";
      XCURSOR_THEME = theme.cursor.x.name;
      XCURSOR_SIZE = cursorSize;

      HYPRCURSOR_THEME = theme.cursor.hypr.name;
      HYPRCURSOR_SIZE = cursorSize;
    };
  };
}
