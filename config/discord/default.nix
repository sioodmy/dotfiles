{ inputs, pkgs, ... }: {
  nixpkgs.overlays = [
    (final: prev:
      let
        wrapped = pkgs.writeShellScriptBin "Discord" ''
          exec ${pkgs.discocss}/bin/discocss
        '';
      in {
        discord-css = pkgs.symlinkJoin {
          name = "discord";
          paths =
            [ wrapped inputs.discord-overlay.packages.${final.system}.discord ];
        };
      })
  ];
  programs.discocss = {
    enable = true;
    discord = pkgs.discord-css;
    discordAlias = false; # Doesn't work so I manually symlink it in the overlay
    css = "asd";
  };
  home.packages = [ pkgs.discord-css ];
}
