{ pkgs, config, inputs, ... }: {

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Pink";
      package = pkgs.catppuccin-gtk.override { size = "compact"; };
    };
    iconTheme = {
      package = pkgs.catppuccin-folders;
      name = "Papirus";
    };
    font = {
      name = "Lato";
      size = 13;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';

  };
}