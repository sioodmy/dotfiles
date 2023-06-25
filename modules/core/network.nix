{
  config,
  pkgs,
  lib,
  ...
}: {
  virtualisation.docker.enable = true;
  environment.systemPackages = [pkgs.docker-compose];
  networking = {
    # dns
    nameservers = [ "1.1.1.1" "1.0.0.1"];
    networkmanager = {
      enable = true;
      unmanaged = ["docker0" "rndis0"];
      wifi.macAddress = "random";
    };
    firewall = {
      enable = true;
      # if your minecraft server is not worky
      # this is probably why
      allowedTCPPorts = [443 80 22 7000 8080 5432];
      allowedUDPPorts = [443 80 44857 8080];
      allowPing = false;
      logReversePathDrops = true;
    };
  };
  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}
