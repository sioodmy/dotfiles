pkgs: {
  opacity = 1.0;
  background = "232136";

  text = "e0def4";

  regular = {
    background = "2a273f";

    red = "eb6f92";
    green = "3e8fb0";
    yellow = "f6c177";
    blue = "9ccfd8";
    purple = "c4a7e7";
    cyan = "ea9a97";
    white = "e0def4";
  };

  bright = {
    background = "393552";
    white = "e0def4";
    cyan = "ea9a97";
    purple = "c4a7e7";
    blue = "";
    yellow = "f6c177";
    green = "3e8fb0";
    red = "eb6f92";
  };

  base00 = "232136";
  base01 = "2a273f";
  base02 = "393552";
  base03 = "6e6a86";
  base04 = "908caa";
  base05 = "e0def4";
  base06 = "e0def4";
  base07 = "56526e";
  base08 = "eb6f92";
  base09 = "f6c177";
  base0A = "ea9a97";
  base0B = "3e8fb0";
  base0C = "9ccfd8";
  base0D = "c4a7e7";
  base0E = "f6c177";
  base0F = "56526e";

  accent = "c4a7e7";
  wallpaper = let
    path = "rosepine/clouds.jpg";
    wallpapers = (pkgs.callPackages ./_sources/generated.nix {}).wallpapers;
  in "${wallpapers.src}/${path}";

  bat = "Nord";
  cursor = {
    hypr = {
      package = pkgs.rose-pine-hyprcursor;
      name = "rose-pine-hyprcursor";
    };
    x = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RoséPine";
    };
  };

  nvim = {
    enable = true;
    # uses generated base16 them if set to false

    package = pkgs.vimPlugins.rose-pine;
    name = "rose-pine-moon";
    configExtra = "";
  };

  gtk = {
    enable = true;
    # uses generated base16 theme if set to false

    package = pkgs.rose-pine-gtk-theme;
    name = "rose-pine-gtk";
  };
}
