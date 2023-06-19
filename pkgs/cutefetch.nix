{ stdenvNoCC, lib }:

stdenvNoCC.mkDerivation rec {
  pname = "cutefetch";
  version = "21.37";

  src = ./.;

  dontBuild = true;

  installPhase = ''
    install -Dm755 -t $out/bin cutefetch
  '';

  meta = with lib; {
    description = "A pretty system information tool written in POSIX sh";
    homepage = "https://sioodmy.dev";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ sioodmy ];
  };
}
