{ config, lib, inputs, ... }:

{
  imports = [ ../../modules/home/default.nix ];
  config.modules = {
    desktop = {
      awesome.enable = true;
      eww.enable = true;
      gtk.enable = true;
      picom.enable = true;
      xresources.enable = true;
      lockscreen.enable = true;
    };
    programs = {
      chromium.enable = true;
      kitty.enable = true;
      foot.enable = true;
      zathura.enable = true;
      dunst.enable = true;
      rofi.enable = true;
      mpv.enable = true;
    };
    services = {
      sxhkd.enable = true;
      redshift.enable = true;
      udiskie.enable = true;
    };
    cli = {
      nvim.enable = true;
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
