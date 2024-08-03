{pkgs, ...}: {
  basePackage = pkgs.swayidle;
  flags = [
    "-w"
    "timeout"
    "300"
    "gtklock"
    "timeout"
    "600"
    "niri msg action power-off-monitors"
    "before-sleep"
    "gtklock"
  ];
}
