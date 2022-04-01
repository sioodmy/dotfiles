{ pkgs, ... }: {
  networking = {
    hostName = "graphene";
    networkmanager.enable = true;
    interfaces = { enp24s0.useDHCP = true; };
    firewall = {
      enable = true;
      allowedTCPPorts = [ 443 80 25565 ];
      allowedUDPPorts = [ 443 80 44857 ];
      allowPing = false;
      logReversePathDrops = true;
      extraCommands = ''
        ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --sport 44857 -j RETURN
        ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --dport 44857 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --sport 44857 -j RETURN || true
        ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --dport 44857 -j RETURN || true
      '';
    };
  };
}
