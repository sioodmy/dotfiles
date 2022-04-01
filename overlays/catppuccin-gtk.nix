{ lib, stdenv, fetchzip }:

stdenv.mkDerivation rec {
  pname = "cattpuccin-gtk";
  version = "0.1.3";

  src = fetchzip {
    url =
      "https://github.com/catppuccin/gtk/releases/download/update_27_01_22/Catppuccin-green-dark-compact.zip";
    sha256 = "Ubdn6UlIdsa+ugVejzOjSFudH/yKzJFu/ebUh5Ify2A=";
  };

  installPhase = ''
    mkdir -p $out/share/themes/Catppuccin-green
    cp -va index.theme gtk-2.0 gtk-3.0 metacity-1 $out/share/themes/Catppuccin-green
  '';

  meta = {
    description = "GTK theme for catppuccin. Warm dark theme for the masses!";
    homepage = "https://github.com/catppuccin/gtk";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [ lib.maintainers.sioodmy ];
  };
}
