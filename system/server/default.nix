{pkgs, ...}:
# TODO
{
  # imports = [./traggo.nix];
  services.nginx = {
    enable = true;
    package = pkgs.nginx.override {openssl = pkgs.libressl;};
  };

  services.radicale = {
    enable = true;
    settings = {
      server.hosts = ["0.0.0.0:5232"];
    };
  };

  networking.firewall = {
    allowedUDPPorts = [51820 5232];
  };

  boot.kernelModules = ["wireguard"];
  networking.wireguard = {
    enable = true;
  };
}
