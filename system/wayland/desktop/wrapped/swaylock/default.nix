{
  pkgs,
  colors,
  ...
}: let
  inside = colors.base01;
  outside = colors.base01;
  ring = colors.base05;
  text = colors.base05;
  positive = colors.base0B;
  negative = colors.base08;

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

  extraFlags = [
    "-n"
    "-S"
    "--clock"
    "--indicator"
  ];
in {
  basePackage = pkgs.swaylock-effects;
  flags = builtins.concatLists (builtins.map (key: ["--${key}" (builtins.toString settings.${key})]) (builtins.attrNames settings)) ++ extraFlags;
}
