{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    clang
    gnumake
    cargo
    go
    cargo
    gcc
  ];
}
