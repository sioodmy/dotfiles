{ pkgs, config, ... }:

let
  wrapped = pkgs.writeShellScriptBin "Discord" ''
    exec ${pkgs.discocss}/bin/discocss
  '';
  discord-css = pkgs.symlinkJoin {
    name = "discord";
    paths = [ wrapped pkgs.discord ];
  };

in {
  programs.discocss = {
    enable = true;
    discordAlias = false;
    discord = discord-css;
    css = builtins.readFile "${pkgs.fetchurl {
      url =
        "https://raw.githubusercontent.com/catppuccin/discord/0576dcc2dece84f47894003e8f10fa15eb2db661/main.css";
      sha256 = "sha256-EFDIs4SOPlJpxc25vhzDJ660r84vrM/20aVzE4fpo/A=";
    }}";
  };

  home.packages = [ discord-css ];
}
