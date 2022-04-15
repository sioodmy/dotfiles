{ config, pkgs, lib, ... }:

{
  import = ../../home;
  config.modules.cli = {
    nvim.enable = true;
  };
}
