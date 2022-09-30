{ lib, stdenv, fetchFromGitHub, gtk3, pantheon, breeze-icons, gnome-icon-theme
, hicolor-icon-theme }:

stdenv.mkDerivation rec {
  pname = "papirus-icon-theme";
  version = "20220302";

  src = fetchFromGitHub {
    owner = "PapirusDevelopmentTeam";
    repo = pname;
    rev = version;
    sha256 = "sha256-X92an2jGRgZ/Q3cr6Q729DA2hs/2y34HoRpB1rxk0hI=";
  };

  nativeBuildInputs = [ gtk3 ];

  propagatedBuildInputs = [
    pantheon.elementary-icon-theme
    breeze-icons
    gnome-icon-theme
    hicolor-icon-theme
  ];

  dontDropIconThemeCache = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    mv {,e}Papirus* $out/share/icons
    for theme in $out/share/icons/*; do
      gtk-update-icon-cache $theme
    done
    runHook postInstall
  '';

  meta = with lib; {
    description = "Catppuccin Papirus icon theme";
    homepage = "https://github.com/catppuccin/papirus-folders";
    license = licenses.mit;
    platforms = platforms.linux;
    #maintainers = with maintainers; [ romildo fortuneteller2k ];
  };
}
