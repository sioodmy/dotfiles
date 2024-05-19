{
  inputs,
  config,
  ...
}: let
  inherit (config.age) secrets;
in {
  imports = [inputs.simple-nixos-mailserver.nixosModule];
  # credits: raf <3
  mailserver = {
    enable = true;
    # mailDirectory = "/srv/storage/mail/vmail";
    # dkimKeyDirectory = "/srv/storage/mail/dkim";
    # sieveDirectory = "/srv/storage/mail/sieve";
    openFirewall = true;
    enableImap = true;
    enableImapSsl = true;
    enablePop3 = false;
    enablePop3Ssl = false;
    enableSubmission = false;
    enableSubmissionSsl = true;
    hierarchySeparator = "/";
    localDnsResolver = false;
    fqdn = "mail.sioodmy.dev";
    certificateScheme = "acme-nginx";
    domains = ["sioodmy.dev"];
    loginAccounts = {
      "me@sioodmy.dev" = {
        hashedPasswordFile = secrets.mailserver.path;
        aliases = [
          "hello"
          "sioodmy"
          "me@sioodmy.dev"
          "admin"
          "admin@sioodmy.dev"
          "root"
          "root@sioodmy.dev"
          "postmaster"
          "postmaster@sioodmy.dev"
        ];
      };
    };
  };

  services.radicale = {
    enable = true;
    settings = {
      server.hosts = ["0.0.0.0:5232"];
      auth = {
        type = "htpasswd";
        htpasswd_filename = secrets.caldav.path;
        htpasswd_encryption = "bcrypt";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [5232];
  services.nginx = {
    virtualHosts = {
      "cal.sioodmy.dev" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:5232";
          extraConfig = ''
            proxy_set_header  X-Script-Name /;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass_header Authorization;
          '';
        };
      };
    };
  };
}
