{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    desktop = {
      gtk.enable = true;
      hyprland.enable = true;
      swaylock.enable = true;
      waybar.enable = true;
    };
    programs = {
      firefox.enable = true;
      brave.enable = false;
      rofi.enable = true;
      kitty.enable = true;
      mako.enable = true;
      tmux.enable = true;
      neofetch.enable = true;
      zathura.enable = true;
      wofi.enable = true;
      vim.enable = true;
      tools.enable = true;
      shell.enable = true;
    };
  };
}
