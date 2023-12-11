{pkgs, ...}: {
  home.packages = with pkgs; [playerctl pavucontrol pulsemixer imv];
  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      bindings = {
        UP = "add volume +2";
        DOWN = "add volume -2";
      };
      config = {
        hwdec = "auto";
        border = false;
      };
      scripts = with pkgs.mpvScripts; [mpris thumbnail sponsorblock];
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [wlrobs];
    };
  };
}
