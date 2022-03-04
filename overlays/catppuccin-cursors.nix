{ lib, stdenv, fetchTarball, ... }:

stdenv.mkDerivation rec {
  pname = "cattpuccin-cursors";
  version = "0.1.3";

  src = fetchTarball {
    url = "https://github.com/catppuccin/cursors/raw/e5a04bcdd953f8cc9fdc9909da24d63319fa252d/cursors/Catppuccin-Dark-Cursors.tar.gz";
    sha256 = "92a3267a120da3b378d443641526d78f87e86d19be8af6ca97c2e4161a04a111";
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
