{
  inputs,
  pkgs,
  colors,
  ...
}: {
  bottom = import ./bottom.nix {inherit inputs pkgs;};
  nvim = import ./nvim {inherit inputs pkgs colors;};
}
