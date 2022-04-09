{ config, pkgs, ... }:

let
  opener = pkgs.writeScriptBin "open" (builtins.readFile ./open);
in
{
  home.packages = [ opener pkgs.file ];
}
