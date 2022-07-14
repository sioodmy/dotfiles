{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.cli.xdg;
  defaults = {
    "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    "application/x-bittorrent" = [ "transmission-gtk.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
  };
in {
  options.modules.cli.xdg = { enable = mkEnableOption "xdg"; };

  config = mkIf cfg.enable {
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
