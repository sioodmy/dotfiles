{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.programs.tools;
in {
  options.modules.programs.tools = { enable = mkEnableOption "programs"; };

  config = mkIf cfg.enable {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableZshIntegration = true;
    };
    programs.bat = {
      enable = true;
      config.theme = "Nord";
    };

    xdg = {
      userDirs = {
        enable = true;
        documents = "$HOME/other";
        download = "$HOME/download";
        videos = "$HOME/vids";
        music = "$HOME/music";
        pictures = "$HOME/pics";
        desktop = "$HOME/other";
        publicShare = "$HOME/other";
        templates = "$HOME/other";
      };
    };

  };
}
