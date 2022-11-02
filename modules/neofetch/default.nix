{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.neofetch;
in {
  options.modules.programs.neofetch = {enable = mkEnableOption "neofetch";};

  config = mkIf cfg.enable {
    home.packages = [pkgs.neofetch];
    home.file.".config/neofetch/config.conf".text = import ./config.nix;
  };
}
