{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.cli.bat;
in {
  options.modules.cli.bat = { enable = mkEnableOption "bat"; };
  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        paging = "never";
        style = "numbers";
        theme = "ansi";
      };
    };
  };
}
