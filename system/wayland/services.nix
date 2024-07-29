{
  pkgs,
  inputs,
  ...
}: {
  systemd.services = {
    seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${pkgs.seatd}/bin/seatd -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = ["multi-user.target"];
    };
  };

  services = {
    mullvad-vpn.enable = true;
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "river";
          user = "sioodmy";
        };
        default_session = initial_session;
        terminal.vt = 1;
      };
    };

    gnome.glib-networking.enable = true;
    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "suspend";
      extraConfig = ''
        HandlePowerKey=suspend
        HibernateDelaySec=3600
      '';
    };

    lorri.enable = true;
    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;
  };
}
