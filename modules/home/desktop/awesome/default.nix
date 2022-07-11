{ config, pkgs, lib, fetchurl, ... }:

with lib;

let cfg = config.modules.desktop.awesome;
in {
  options.modules.desktop.awesome = { enable = mkEnableOption "awesome"; };

  config = mkIf cfg.enable {

    home.packages = [ pkgs.inotify-tools pkgs.pulseaudio ];

    home.pointerCursor = {
      package = pkgs.catppuccin-cursors;
      name = "Catppuccin-Dark-Cursors";
      size = 32;
    };

    # Link configuration
    home.file.".config/awesome".source = ./config;

    xsession.windowManager.awesome = {
      enable = true;
      package = pkgs.awesome-git;
      luaModules = with pkgs.luaPackages; [ vicious luarocks ];
    };
  };

}
