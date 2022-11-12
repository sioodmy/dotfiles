{
  config,
  pkgs,
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
      root = "/srv/www/sioodmy.dev";
    };
    virtualHosts."git.sioodmy.dev" = {
      enableACME = true;
      forceSSL = true;
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
    settings.ui.DEFAULT_THEME = "arc-green";
    settings.session.COOKIE_SECURE = true;
    # settings.service.DISABLE_REGISTRATION = true;
  };
}
