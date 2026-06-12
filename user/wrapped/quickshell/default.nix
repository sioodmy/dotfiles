{
  pkgs,
  inputs,
  ...
}:
pkgs.symlinkJoin {
  name = "quickshell-wrapped";
  paths = [inputs.qml-niri.packages.${pkgs.stdenv.system}.quickshell];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/quickshell --add-flags "-p ${inputs.quickshell-config}"  '';
}
