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
      firefox.enable = true;
      foot.enable = true;
      mako.enable = true;
      tmux.enable = true;
      zathura.enable = false;
      wofi.enable = true;
      mpv.enable = true;
      vim.enable = true;
      tools.enable = true;
      shell.enable = true;
    };
  };
}
