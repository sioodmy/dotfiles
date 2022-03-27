{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "fetch";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "sioodmy";
    repo = "fetch";
    rev = "f8d14b7f1ba3e8e8bea35355c5e1645729a89d4c";
    sha256 = "SVtEE991WfQUcNSHIf42BVfQVuC71sT7QYH1P4hJKmA=";
  };

  dontBuild = true;
  dontConfigure = true;

  installPhase = "install -D $src/${pname} $out/bin/${pname}";

  meta = with lib; {
    description = "Simple system fetch utility";
    homepage = "https://github.com/sioodmy/fetch";
    maintainers = with maintainers; [ sioodmy ];
    platforms = platforms.linux;
  };
}
