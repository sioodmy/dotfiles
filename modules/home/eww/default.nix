{ inputs, pkgs, ... }:

{
  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.hostPlatform.system}.eww-wayland;
    configDir = ./config;
  };
}
