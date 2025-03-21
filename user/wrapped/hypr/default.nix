{
  pkgs,
  lib,
  theme,
  ...
}: let
  toHyprConf = import ./tohyprconf.nix lib;
in
  pkgs.symlinkJoin {
    name = "hypr-and-friends";
    paths = builtins.map (x: (pkgs.symlinkJoin {
      name = "${x}-wrapped";
      paths = let
        pname = lib.strings.toLower x;
      in
        [pkgs.${pname}] ++ import ./packages.nix pkgs ++ [ theme.cursor.hypr.package ];
      buildInputs = [pkgs.makeWrapper];
      postBuild = let
        config = pkgs.writeText "${x}.conf" (toHyprConf {
          attrs = import ./configs/${x}.nix theme;
        });
      in ''
        wrapProgram $out/bin/${x} --add-flags "-c ${config}"
      '';
    })) ["Hyprland" "hyprlock" "hypridle"];
  }
