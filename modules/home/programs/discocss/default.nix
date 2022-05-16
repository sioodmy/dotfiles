{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.programs.discocss;

in {
  options.modules.programs.discocss = { enable = mkEnableOption "discocss"; };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [ discord discocss ];
    xdg.configFile."discocss/custom.css".source = ./nord-glasscord.theme.css;

  };
}

