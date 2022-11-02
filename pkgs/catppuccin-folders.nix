{
  lib,
  stdenv,
  fetchFromGitHub,
  papirus-icon-theme,
}:
stdenv.mkDerivation rec {
  pname = "catppuccin-folders";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "papirus-folders";
    rev = "5b1e93fa40cbc63e158ac4aa4f453e8028941ab4";
    sha256 = "sha256-9IRGxQ3IyOIaXSMKYdZIbuhPNzmuT/zIcAAmyPbXktk=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/Papirus
    cp -r ${papirus-icon-theme}/share/icons/Papirus $out/share/icons
    chmod -R u+rw $out
    cp -r src/* $out/share/icons/Papirus
    bash ./papirus-folders -C cat-frappe-pink --theme $out/share/icons/Papirus -o
  '';
}
