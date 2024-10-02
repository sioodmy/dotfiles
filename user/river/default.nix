{
  pkgs,
  theme,
  ...
}:
# https://github.com/viperML/wrapper-manager/issues/14
pkgs.symlinkJoin {
  name = "river-wrapped";
  paths = [
    pkgs.river
    (import ./scripts/infoscript.nix pkgs)
    (import ./scripts/osd.nix pkgs)
  ];
  buildInputs = [pkgs.makeWrapper];
  postBuild = ''
    wrapProgram $out/bin/river --add-flags "-c ${import ./init.nix {inherit pkgs theme;}}";
  '';
}
