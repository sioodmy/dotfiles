{ lib, stdenv, fetchFromGitHub, xorg }:

stdenv.mkDerivation rec {
  pname = "bspswallow";
  version = "unstable-2021-05-20";

  src = fetchFromGitHub {
    owner = "JopStro";
    repo = pname;
    rev = "77edf5d64be7ee6014d0d1b38c6a3a36096234a9";
    sha256 = "SVtEE991WfQUcNSHIf42BVfQVuC71sT7QYH1P4hJKmA=";
  };

  dontBuild = true;
  dontConfigure = true;

  buildInputs = [ xorg.xprop ];

  installPhase = "install -D $src/${pname} $out/bin/${pname}";

  meta = with lib; {
    description = "DWM-like swallowing for BSPWM";
    homepage = "https://github.com/JopStro/bspswallow";
    maintainers = with maintainers; [ kranzes ];
    platforms = platforms.linux;
  };
}
