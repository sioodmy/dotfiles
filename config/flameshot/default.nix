{ pkgs, config, theme, ...}:

{
  services.flameshot = with theme.colors; {
    enable = true;
    settings = {
      General = {
        showStartupLaunchMessage = false;
        uiColor = "${ac}";
        contrastUiColor = "${fg}";
        drawColor = "${c1}";
        showHelp = false;
        showSidePanelButton = false;
      };
    };
  };
}
