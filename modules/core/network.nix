{
  config,
  pkgs,
  lib,
  ...
}: {
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [docker-compose speedtest-cli];
  networking = {
    # dns
    nameservers = ["127.0.0.1" "::1"];
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager = {
      enable = true;
      dns = "none";
      unmanaged = ["docker0" "rndis0"];
      wifi.macAddress = "random";
    };
    firewall = {
      enable = true;
      # if your minecraft server is not worky
      # this is probably why
      allowedTCPPorts = [2137 33703];
      allowedUDPPorts = [33703];
      allowPing = false;
      logReversePathDrops = true;
    };
  };
  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}
