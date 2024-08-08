{
  pkgs,
  colors,
  ...
}: {
  basePackage = pkgs.waylock;
  flags = with colors; [
    "-init-color"
    "0x${base00}"
    "-input-color"
    "0x${base01}"
    "-fail-color"
    "0x${base08}"
  ];
}
