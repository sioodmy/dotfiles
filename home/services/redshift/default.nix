{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.services.redshift;
in {
  options.modules.services.redshift = { enable = mkEnableOption "redshift"; };

  config = mkIf cfg.enable {
    services.redshift = {
      enable = true;

      # Warsaw
      latitude = 52.22977;
      longitude = 21.01178;
    };
  };
}
