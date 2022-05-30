{ pkgs, inputs, lib, config, ... }:
with lib;
let
  cfg = config.modules.programs.discocss;
  discord-css = pkgs.symlinkJoin {
    name = "discord";
    paths =
      [
        (pkgs.writeShellScriptBin "Discord" ''
          exec ${pkgs.discocss}/bin/discocss
        '')
        inputs.discord-overlay.packages."x86_64-linux".discord
      ];
    };

in {
  options.modules.programs.discocss = { enable = mkEnableOption "discocss"; };

  config = mkIf cfg.enable {

    programs.discocss = {
      enable = true;
      discordAlias = false;
      css = builtins.readFile ./custom.css;
    };

    home.packages = [ discord-css ];

  };
}

