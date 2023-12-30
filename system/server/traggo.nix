{pkgs, ...}: let
  traggo-server = pkgs.buildGoModule {
    pname = "traggo-server";
    version = "0.3.0";
    src = pkgs.fetchFromGitHub {
      owner = "traggo";
      repo = "server";
      rev = "6842b5c706d8eaf4608d984669463f441f270fd1";
      sha256 = "viwC2OpvAEpvDw6Cj9Os9dS7/6UlVR4Jq9ZBHL6ELSg=";
    };
    vendorHash = "";
  };
in {
  environment = {
    systemPackages = [traggo-server];
    variables = {
      TRAGGO_DEFAULT_USER_NAME = "sioodmy";
      TRAGGO_DEFAULT_USER_PASS = "sioodmy";
    };
  };

  networking.firewall.allowedUDPPorts = [3030];

  systemd.services.traggo = {
    description = "self-hosted tag-based time tracking";
    wantedBy = ["multi-user.target"];
    wants = ["network.target"];
    after = [
      "network-online.target"
      "NetworkManager.service"
      "systemd-resolved.service"
    ];
    serviceConfig = {
      ExecStart = ''${traggo-server}/bin/traggo-server'';
      Restart = "always";
    };
  };
}
