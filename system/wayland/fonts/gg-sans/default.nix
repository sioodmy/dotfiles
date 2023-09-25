# credits:
# - neoney
# - discord, actually not (fuck them)
{
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "gg-sans";
  version = "0.0.1";

  src = ./ttf;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = "Discord's gg Sans font";
    platforms = platforms.all;
  };
}
