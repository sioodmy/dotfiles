{ lib, stdenv, ... }:

stdenv.mkDerivation rec {
  pname = "cattpuccin-cursors";
  version = "0.1.3";

  src = fetchTarball {
    url = "https://github.com/catppuccin/cursors/raw/e5a04bcdd953f8cc9fdc9909da24d63319fa252d/cursors/Catppuccin-Dark-Cursors.tar.gz";
    sha256 = "0jnjr0g7j7nwbbf961x5y1s1n2d79f8q8w2qsmn2xm1p1qyay0vd";
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
