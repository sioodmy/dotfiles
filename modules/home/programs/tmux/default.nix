{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.tmux;
in {
  options.modules.programs.tmux = { enable = mkEnableOption "tmux"; };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      keyMode = "vi";
      aggressiveResize = true;
      clock24 = true;
      extraConfig = ''
        set -g mouse on
      '';
    };
  };
}
