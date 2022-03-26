{ config, pkgs, ... }:

{
  services.screen-locker = {
    enable = true;
    lockCmd = "dm-tool lock";
    inactiveInterval = 17;
    xautolock.extraOptions = [ "-corners 0-00" ];
  };
}
