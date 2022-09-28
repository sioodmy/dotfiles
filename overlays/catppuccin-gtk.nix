{ lib, stdenv, fetchzip, ... }:

stdenv.mkDerivation rec {
  pname = "cattpuccin-gtk";
  version = "0.2.7";

  src = fetchzip {
    url =
      "https://github.com/catppuccin/gtk/releases/download/v-0.2.7/Catppuccin-Frappe-Pink.zip";
    sha256 = "";
  };

  installPhase = ''
    mkdir -p $out/share/themes/Catppuccin-Frappe-Pink
    ls | xargs mv -t $out/share/themes/Catppuccin-Frappe-Pink
  '';

  meta = {
    description = "Soothing pastel theme for GTK3";
    homepage = "https://github.com/catppuccin/gtk";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [ lib.maintainers.sioodmy ];
  };
}
