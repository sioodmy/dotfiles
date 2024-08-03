{
  pkgs,
  colors,
  ...
}: {
  basePackage = pkgs.mako;
  flags = with colors; [
    "--font"
    "Lexend 11"

    "--border-radius"
    "8"

    "--padding"
    "8"

    "--border-size"
    "5"

    "--background-color"
    "#${base02}"

    "--border-color"
    "#${base03}"

    "--text-color"
    "#${base05}"

    "--progress-color"
    "#${base04}"

    "--default-timeout"
    "4000"
  ];
  renames = {
    "mako" = "mako-wrapped";
  };
}
