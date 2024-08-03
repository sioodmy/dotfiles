{pkgs, ...}: let
  config = pkgs.writeText "config.ini" ''
    [main]
    modules = ${pkgs.gtklock-powerbar-module}/lib/gtklock/powerbar-module.so;
  '';
in {
  basePackage = pkgs.gtklock;
  flags = ["-c" "${config}" "-s" "${./style.css}"];
}
