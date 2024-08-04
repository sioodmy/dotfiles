{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      clang
      gnumake
      cargo
    ])
    ++ [
      inputs.zig-overlay.packages.${pkgs.system}.master
    ];
}
