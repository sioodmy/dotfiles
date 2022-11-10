{
  config,
  pkgs,
  ...
}: {
  networking = {
    # dns
    nameservers = ["1.1.1.1" "1.0.0.1"];
    networkmanager = {
      enable = true;
      unmanaged = ["docker0" "rndis0"];
      wifi.macAddress = "random";
    };
    firewall = {
      enable = true;
      # if your minecraft server is not worky
      # this is probably why
      allowedTCPPorts = [443 80];
      allowedUDPPorts = [443 80 44857];
      allowPing = false;
      logReversePathDrops = true;
    };
  };
}
