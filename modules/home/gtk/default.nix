{
  self,
  pkgs,
  config,
  inputs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Pink";
      package = self.packages.${pkgs.system}.catppuccin-gtk;
    };
    iconTheme = {
      package = self.packages.${pkgs.system}.catppuccin-folders;
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

  # cursor theme
  home.pointerCursor = {
    package = self.packages.${pkgs.system}.catppuccin-cursors;
    name = "Catppuccin-Frappe-Dark";
    size = 16;
  };
  home.pointerCursor.gtk.enable = true;

  # credits: bruhvko
  # catppuccin theme for qt-apps
  home.packages = with pkgs; [libsForQt5.qtstyleplugin-kvantum];

  xdg.configFile."Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Frappe-Pink/Catppuccin-Frappe-Pink.kvconfig";
    sha256 = "0pl936nchif2zsgzy4asrlc3gvv4fv2ln2myrqx13r6xra1vkcqs";
  };
  xdg.configFile."Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Frappe-Pink/Catppuccin-Frappe-Pink.svg";
    sha256 = "1b92j0gb65l2pvrf90inskr507a1kwin1zy0grwcsdyjmrm5yjrv";
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=catppuccin

    [Applications]
    catppuccin=Dolphin, dolphin, Nextcloud, nextcloud, qt5ct, org.kde.dolphin, org.kde.kalendar, kalendar, Kalendar, qbittorrent, org.qbittorrent.qBittorrent
  '';
}
