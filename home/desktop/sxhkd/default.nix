{ pkgs, config, ... }:

{
  services.sxhkd = {
    enable = true;
    extraConfig = builtins.readFile ./sxhkdrc;
  };
}
