{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.tools;
in {
  options.modules.cli.tools = { enable = mkEnableOption "tools"; };

  config = mkIf cfg.enable {
    programs.gpg = { enable = true; };

    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "qt";
    };

    programs.bat = {
      enable = true;
      config.theme = "nord";
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
      mimeApps = {
        enable = true;
        associations.added = defaults;
        defaultApplications = defaults;
      };
    };

  };
}
