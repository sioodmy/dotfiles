{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "fetch";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "sioodmy";
    repo = "fetch";
    rev = "abe2e031df13f6108b14cee10932538132c8afe1";
    sha256 = "3pAo5/1rIg8IFQJhFmwT/2n9mA9kgMwvqY5XqMhU5B8=";
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
