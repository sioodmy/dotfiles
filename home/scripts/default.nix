{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "bcn" (builtins.readFile ./bcn))
  ];
}
