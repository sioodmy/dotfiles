{
  pkgs,
  inputs,
  ...
}:
# TODO
{
imports = [inputs.schizosearch.nixosModules.default];
  services.nginx = {
    enable = true;
    # package = pkgs.nginx.override {openssl = pkgs.libressl;};
    package = pkgs.angieQuic;

    # # lets be more picky on our ciphers and protocols
    # sslCiphers = "EECDH+aRSA+AESGCM:EDH+aRSA:EECDH+aRSA:+AES256:+AES128:+SHA1:!CAMELLIA:!SEED:!3DES:!DES:!RC4:!eNULL";
    # sslProtocols = "TLSv1.3 TLSv1.2";

     virtualHosts = {
      "sioodmy.dev" = {          
          root = "${inputs.sioodmy-dev.packages.${pkgs.system}.website}/";
          enableACME = true;
          forceSSL = true;
      };
      "search.sioodmy.dev" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:3000";
        };
        quic = true;
        forceSSL = true;
        enableACME = true;
      };
    };
  };

  services.schizosearch.enable = true;
  security.acme = {
    acceptTerms = true;
    defaults.email = "hello@sioodmy.dev";
  };

  # services.schizosearch = {
  #   enable = true;
  #   openFirewall = true;
  #   settings.port = 3000;
  # };

  networking.firewall = {
    allowedUDPPorts = [51820 5232];
    allowedTCPPorts = [5232 80 3000];
  };

}
