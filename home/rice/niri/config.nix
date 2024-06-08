{
  theme,
  pkgs,
  ...
}:
with theme.colors; {
  imports = [./binds.nix];
  programs.niri.settings = {
    spawn-at-startup = [
      {
        command = [
          "run-as-service"
          "waybar"
        ];
      }
      {
        command = [
          "${pkgs.dbus}/bin/dbus-update-activation-environment"
          "--systemd"
          "DISPLAY"
          "WAYLAND_DISPLAY"
          "SWAYSOCK"
          "XDG_CURRENT_DESKTOP"
          "XDG_SESSION_TYPE"
          "NIXOS_OZONE_WL"
          "XCURSOR_THEME"
          "XCURSOR_SIZE"
          "XDG_DATA_DIRS"
        ];
      }
      {
        command = [
          "/usr/libexec/polkit-gnome-authentication-agent-1"
        ];
      }
    ];
    outputs."eDP-1".position = {
      x = 0;
      y = 0;
    };
    outputs."DP-2" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 144.001;
      };
      position = {
        x = 0;
        y = -1080;
      };
    };

    input = {
      keyboard.xkb = {
        layout = "pl";
        options = "caps:escape";
      };
      touchpad = {
        # disable when typing /trackpointing
        dwt = true;
        dwtp = true;
        natural-scroll = true;
        click-method = "clickfinger";
      };
      focus-follows-mouse = false;
      warp-mouse-to-focus = true;
      trackpoint.accel-speed = 0.001;
    };

    layout = {
      gaps = 16;
      center-focused-column = "never";
      preset-column-widths = [
        {proportion = 0.333;}
        {proportion = 0.5;}
        {proportion = 0.666;}
      ];
      default-column-width = {proportion = 0.5;};

      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#${accent}";
        inactive.color = "#${overlay0}";
      };
    };

    animations = let
      butter = {
        spring = {
          damping-ratio = 0.75;
          epsilon = 0.00010;
          stiffness = 400;
        };
      };
      smooth = {
        spring = {
          damping-ratio = 0.58;
          epsilon = 0.00010;
          stiffness = 735;
        };
      };
    in {
      slowdown = 1.3;
      horizontal-view-movement = butter;
      window-movement = butter;
      workspace-switch = butter;
      window-open = smooth;
      window-close = smooth;
    };

    window-rules = [
      {
        geometry-corner-radius = let
          radius = 8.0;
        in {
          bottom-left = radius;
          bottom-right = radius;
          top-left = radius;
          top-right = radius;
        };
        clip-to-geometry = true;
      }
      {
        matches = [{app-id = "^firefox$";}];
        open-on-workspace = "2";
      }
    ];

    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/pics/ss/ss%Y-%m-%d %H-%M-%S.png";
  };
}
