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
      go
      cargo
      gcc
    ])
    ++ [
      inputs.zig-overlay.packages.${pkgs.system}.master
    ];
}
