{
  pkgs,
  ...
}:
pkgs.symlinkJoin {
  name = "bat-wrapped";
  paths = [ pkgs.bat ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/bat
  '';
}
