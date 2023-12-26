{pkgs, ...}:
# TODO
{
  services.nginx = {
    enable = true;
    package = pkgs.nginx.override {openssl = pkgs.libressl;};
  };

  networking.firewall = {
    allowedUDPPorts = [51820];
  };

  boot.kernelModules = ["wireguard"];
  networking.wireguard = {
    enable = true;
  };
}
