{
  pkgs,
  theme,
  ...
}: let
  inherit (builtins) concatStringsSep attrNames map;
  inside = theme.base01;
  outside = theme.base01;
  ring = theme.base05;
  text = theme.base05;
  positive = theme.base0B;
  negative = theme.base08;

  settings = {
    color = outside;
    scaling = "fill";
    inside-color = inside;
    inside-clear-color = inside;
    inside-caps-lock-color = inside;
    inside-ver-color = inside;
    inside-wrong-color = inside;
    key-hl-color = positive;
    layout-bg-color = inside;
    layout-border-color = ring;
    layout-text-color = text;
    ring-color = ring;
    ring-clear-color = negative;
    ring-caps-lock-color = ring;
    ring-ver-color = positive;
    ring-wrong-color = negative;
    separator-color = "00000000";
    text-color = text;
    text-clear-color = text;
    text-caps-lock-color = text;
    text-ver-color = text;
    text-wrong-color = text;
    effect-blur = "3x3";
    font-size = 24;
    indicator-radius = 120;
    indicator-thickness = 15;
  };

  flags = (concatStringsSep " " (map (key: "--${key}=${builtins.toString settings.${key}}") (attrNames settings))) + "-n -S --clock --indicator";
in
  pkgs.symlinkJoin {
    name = "swaylock-wrapped";
    paths = [pkgs.swaylock-effects];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/swaylock --add-flags "${flags}"
    '';
  }
