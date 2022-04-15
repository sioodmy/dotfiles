{ pkgs, lib, config, theme, ... }:
with lib;
let cfg = config.modules.programs.flameshot;
in {
  options.modules.programs.flameshot = { enable = mkEnableOption "flameshot"; };

  config = mkIf cfg.enable {
    services.flameshot = with theme.colors; {
      enable = true;
      settings = {
        General = {
          showStartupLaunchMessage = false;
          uiColor = "#${ac}";
          contrastUiColor = "#${fg}";
          drawColor = "#${c1}";
          showHelp = false;
          showSidePanelButton = false;
        };
      };
    };
  };
}
