{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/home/default.nix ];
  config.modules = {
    desktop = {
      gtk.enable = true;
      hyprland.enable = true;
      swaylock.enable = true;
    };
    programs = {
      foot.enable = true;
      zathura.enable = true;
      wofi.enable = true;
      mpv.enable = true;
      vim.enable = true;
      tools.enable = true;
      shell.enable = true;
    };
  };
}
