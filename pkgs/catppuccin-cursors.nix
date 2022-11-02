{
  lib,
  stdenv,
  fetchzip,
  ...
}:
stdenv.mkDerivation rec {
  pname = "cattpuccin-cursors";
  version = "0.2.7";

  src = fetchzip {
    url = "https://github.com/catppuccin/cursors/raw/21942800ad34b357a12079718a1faa88f0bccf28/cursors/Catppuccin-Frappe-Dark-Cursors.zip";
    sha256 = "RCEVxeo3oBNqHogxWM/YqfPoQotirSQTMw15zCahWto=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/Catppuccin-Frappe-Dark
    cp -va index.theme cursors $out/share/icons/Catppuccin-Frappe-Dark
  '';

  meta = {
    description = "Soothing pastel mouse cursors";
    homepage = "https://github.com/catppuccin/cursors";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [lib.maintainers.sioodmy];
  };
}
