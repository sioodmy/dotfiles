{
  pkgs,
  flake,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./kbd_backlight.nix
  ];
  hardware = {
    graphics.enable = true;
    brillo.enable = true;
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "niri";

      SDL_VIDEODRIVER = "wayland";

      _JAVA_AWT_WM_NONEREPARENTING = "1";

      CLUTTER_BACKEND = "wayland";

      GDK_BACKEND = "wayland";

      QT_QPA_PLATFORM = "wayland";
    };
    systemPackages = [
      inputs.dwl.packages.${pkgs.system}.default
    ];
  };

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
      wantedBy = [ "multi-user.target" ];
    };
  };

  services = {
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.niri}/bin/niri-session";
          user = "sioodmy";
        };
        default_session = initial_session;
        terminal.vt = 1;
      };
    };

    gnome.glib-networking.enable = true;
    logind = {
      settings.Login = {
        HandleLidSwitchExternalPower = "suspend";
        # TODO: switch to hibernate once available on asahi
        # prolly not coming soon tho :c
        HandleLidSwitch = "suspend";
      };
    };
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };
}
