{ pkgs, config, ...}:

{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        showStartupLaunchMessage = false;
        uiColor = "#ABE9B3";
        contrastUiColor = "#B5E8E0";
        drawColor = "#ABE9B3";
        showHelp = false;
        showSidePanelButton = false;

      };
    };
  };
}
