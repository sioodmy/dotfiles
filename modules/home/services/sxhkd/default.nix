{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.services.sxhkd;
in {
  options.modules.services.sxhkd = { enable = mkEnableOption "sxhkd"; };

  config = mkIf cfg.enable {
    services.sxhkd = {
      enable = true;
      keybindings = {
       "super + shift + Escape" = "pkill -USR1 -x sxhkd; notify-send 'sxhkd' 'Reloaded config'";
      };
    };
  };
}
