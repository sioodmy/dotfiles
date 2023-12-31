{
  pkgs,
  config,
  ...
}:
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
      auth = {
        type = "htpasswd";
        htpasswd_filename = config.age.secrets.radicale.path;
        htpasswd_encryption = "bcrypt";
      };
      storage = {
        filesystem_folder = "/data/radicale/collections";
      };
    };
  };

  networking.firewall = {
    allowedUDPPorts = [51820 5232];
    allowedTCPPorts = [5232];
  };

  boot.kernelModules = ["wireguard"];
  networking.wireguard = {
    enable = true;
  };
}
