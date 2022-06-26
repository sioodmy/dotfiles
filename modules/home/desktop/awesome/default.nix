{ config, pkgs, lib, fetchurl, ... }:

with lib;

let cfg = config.modules.desktop.awesome;
in
{
  options.modules.desktop.awesome = { enable = mkEnableOption "awesome"; };

  config = mkIf cfg.enable {
    xsession.windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [ vicious luarocks ];
     };
  };

}
