{ config, pkgs, ... }:

{
  hardware.nvidia.modesetting.enable = true;
  xserver.videoDrivers = [ "nvidia" ];
}
