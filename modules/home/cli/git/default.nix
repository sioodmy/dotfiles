{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.git;
in {
  options.modules.cli.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "sioodmy";
      userEmail = "sioodmy@tuta.io";
      extraConfig = {
        init = { defaultBranch = "main"; };
        delta = { syntax-theme = "Nord"; };
      };
      delta = { enable = true; };
    };

  };
}
