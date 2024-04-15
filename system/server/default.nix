{
  pkgs,
  config,
  ...
}:
# TODO
{
  services.nginx = {
    enable = true;
    package = pkgs.nginx.override {openssl = pkgs.libressl;};
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedZstdSettings = true;
    # FIXME: this normally makes the /nginx_status endpoint availabe, but nextcloud hijacks it and returns a SSL error
    # we need it for prometheus, so it would be *great* to figure out a solution
    statusPage = false;

    # lets be more picky on our ciphers and protocols
    sslCiphers = "EECDH+aRSA+AESGCM:EDH+aRSA:EECDH+aRSA:+AES256:+AES128:+SHA1:!CAMELLIA:!SEED:!3DES:!DES:!RC4:!eNULL";
    sslProtocols = "TLSv1.3 TLSv1.2";

    commonHttpConfig = ''
      #real_ip_header CF-Connecting-IP;
      add_header 'Referrer-Policy' 'origin-when-cross-origin';
      add_header X-Frame-Options DENY;
      add_header X-Content-Type-Options nosniff;
    '';
    virtualHosts."search.sioodmy.dev" = {
      locations."/".proxyPass = "http://127.0.0.1:3000";
      extraConfig = ''
        access_log /dev/null;
        error_log /dev/null;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
      '';
      addSSL = true;
      enableACME = true;
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "hello@sioodmy.dev";
  };

  # services.schizosearch = {
  #   enable = true;
  #   openFirewall = true;
  #   settings.port = 3000;
  # };

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
    allowedTCPPorts = [5232 80 3000];
  };

  boot.kernelModules = ["wireguard"];
  networking.wireguard = {
    enable = true;
  };
}
