{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [docker-compose];
    virtualisation = {
    podman = {
      enable = true;
      dockerCompat = false;
      defaultNetwork.settings.dns_enabled = true;
    };
    docker = {
      enable = true;
    };
    libvirtd = {
      enable = true;
    };
  };
    systemd.user.timers."distrobox-update" = {
    enable = true;
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "1h";
      OnUnitActiveSec = "1d";
      Unit = "distrobox-update.service";
    };
  };

  systemd.user.services."distrobox-update" = {
    enable = true;
    script = ''
      ${pkgs.distrobox}/bin/distrobox upgrade --all
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };

}
