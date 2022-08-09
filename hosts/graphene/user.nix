{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/home/default.nix ];
  config.modules = {
    desktop = {
      gtk.enable = true;
      hyprland.enable = true;
      swaylock.enable = true;
      xresources.enable = true;
    };
    programs = {
      chromium.enable = true;
      kitty.enable = true;
      foot.enable = true;
      zathura.enable = true;
      mpv.enable = true;
      minivim.enable = true;
    };
    services = {
      mako.enable = true;
      udiskie.enable = true;
    };
    cli = {
      nvim.enable = false;
      bat.enable = true;
      btm.enable = true;
      cava.enable = true;
      fzf.enable = true;
      git.enable = true;
      music.enable = true;
      zsh.enable = true;
      gpg.enable = true;
      lf.enable = true;
      xdg.enable = true;
    };
  };
}
