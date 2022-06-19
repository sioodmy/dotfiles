{ lib, stdenv, fetchzip, ... }:

stdenv.mkDerivation rec {
  pname = "cattpuccin-cursors";
  version = "0.2.0";

  src = fetchzip {
    url =
      "https://github.com/catppuccin/cursors/raw/1df332a406916a89a07be93adaf785236728077f/cursors/Catppuccin-Macchiato-Dark-Cursors.zip";
    sha256 = "y1Pozu+wPRGl4ICtYuH6rl5B0b5YvbbTTEm48OollsQ=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/Catppuccin-Dark-Cursors
    cp -va index.theme cursors $out/share/icons/Catppuccin-Dark-Cursors
  '';

  meta = {
    description = "Soothing pastel mouse cursors";
    homepage = "https://github.com/catppuccin/cursors";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [ lib.maintainers.sioodmy ];
  };
}
