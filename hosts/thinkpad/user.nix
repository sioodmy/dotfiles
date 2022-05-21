{ config, lib, inputs, ...}:

{
  imports = [ ../../modules/home/default.nix ];

  config.modules = {
    desktop = {
      bspwm.enable = true;
      gtk.enable = true;
      picom.enable = true;
      xresources.enable = true;
      lockscreen.enable = true;
      eww.enable = true;
    };
    programs = {
      discocss.enable = true;
      firefox.enable = true;
      qutebrowser.enable = true;
      kitty.enable = true;
      zathura.enable = true;
      rofi.enable = true;
      dunst.enable = true;
    };
    services = {
      sxhkd.enable = true;
      redshift.enable = true;
      fusuma.enable = true;
      udiskie.enable = true;
    };
    cli = {
      nvim.enable = true;
      bat.enable = true;
      btm.enable = true;
      cava.enable = true;
      fzf.enable = true;
      music.enable = true;
      zsh.enable = true;
      gpg.enable = true;
      lf.enable = true;
      xdg.enable = true;
    };
  };
}
