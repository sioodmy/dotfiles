{pkgs, ...}: let
  config = import ./waybar-conf.nix pkgs;
  style = import ./style.nix pkgs;
in
  pkgs.symlinkJoin {
    name = "waybar-wrapped";
    paths = [
      pkgs.waybar
    ];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/waybar --add-flags "-c ${config} -s ${style}"
    '';
  }
