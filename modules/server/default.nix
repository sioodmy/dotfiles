{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # replace openssl with FUCKING BASED LIBRESSL AAAAAAAAAAA
  nixpkgs.overlays = [
    (final: super: {
      nginxStable = super.nginxStable.override {openssl = super.pkgs.libressl;};
    })
  ];
  security.acme = {
    acceptTerms = true;
    defaults.email = "hello@sioodmy.dev";
    certs."sioodmy.dev" = {
      group = "nginx";
      email = "hello@sioodmy.dev";
    };
  };

  services.openssh.extraConfig = ''
    Match User git
      AuthorizedKeysCommandUser git
      AuthorizedKeysCommand ${pkgs.gitea}/bin/gitea keys -e git -u %u -t %t -k %k
    Match all
  '';

  systemd.services.gitea.serviceConfig.SystemCallFilter =
    lib.mkForce
    "~@clock @cpu-emulation @debug @keyring @memlock @module @obsolete @raw-io @reboot @resources @setuid @swap";

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    virtualHosts."sioodmy.dev" = {
      addSSL = true;
      serverAliases = ["www.sioodmy.dev"];
      enableACME = true;
      extraConfig = "error_page 404 /404.html;";
      # deploy my website
      locations."/".root = inputs.sioodmy-dev.defaultPackage.${pkgs.system};
    };
    virtualHosts."git.sioodmy.dev" = {
      enableACME = true;
      addSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:7000/";
      };
    };
  };

  users.users.git = {
    useDefaultShell = true;
    home = "/var/lib/gitea";
    group = "gitea";
    isSystemUser = true;
  };

  # Gitea Settings
  services.gitea = {
    enable = true;
    lfs.enable = true;

    # Security
    user = "git";
    database.user = "git";

    # Repository
    appName = "sioodmy's gitea instance";
    domain = "git.sioodmy.dev";
    rootUrl = "https://git.sioodmy.dev";
    httpPort = 7000;
    settings = {
      repository.PREFERRED_LICENSES = "GPL-3.0,GPL-2.0,LGPL-3.0,LGPL-2.1";
      server = {
        START_SSH_SERVER = false;
        BUILTIN_SSH_SERVER_USER = "git";
        SSH_PORT = 22;
        DISABLE_ROUTER_LOG = true;
        SSH_CREATE_AUTHORIZED_KEYS_FILE = true;
      };
      attachment.ALLOWED_TYPES = "*/*";
      service.DISABLE_REGISTRATION = true;
      ui.DEFAULT_THEME = "arc-green";
    };
  };

  services.tor.relay.onionServices = {
    # hide ssh from script kiddies
    ssh = {
      version = 3;
      map = [{port = 22;}];
    };
    # feds crying rn
    website = {
      version = 3;
      map = [{port = 80;}];
    };
  };
  services.tor.settings = {
    DnsPort = 9053;
    AutomapHostsOnResolve = true;
    AutomapHostsSuffixes = [".exit" ".onion"];
    EnforceDistinctSubnets = true;
    ExitNodes = "{pl}";
    EntryNodes = "{pl}";
    NewCircuitPeriod = 120;
    DNSPort = 9053;
  };
}
