{ pkgs, config, ... }:

{
  services.betterlockscreen = {
    enable = true;
    arguments = [ "--off 5" "blur" ];

  };
}
