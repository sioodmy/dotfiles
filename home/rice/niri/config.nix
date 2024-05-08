{
  pkgs,
  theme,
  config,
  ...
}:
with theme.colors; {
  programs.niri.settings = {
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
      focus-follows-mouse = true;
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
        geometry-corner-radius = let radius =8.0; in{
          bottom-left = radius;
          bottom-right = radius;
          top-left = radius;
          top-right = radius;
      };
        clip-to-geometry= true;
      }
    ];

    binds = with config.lib.niri.actions; let
      sh = spawn "sh" "-c";
    in {
      "Mod+Return" = {
        action = spawn "${pkgs.foot}/bin/foot";
        cooldown-ms = 500;
      };
      "Mod+Space".action = spawn "${pkgs.fuzzel}/bin/fuzzel";
      "Mod+V".action = sh "${pkgs.cliphist}/bin/cliphist list | fuzzel --dmenu | cliphist decode | wl-copy";
      "Mod+Shift+Period".action = spawn "emoji";

      "XF86AudioRaiseVolume".action = spawn "pamixer" "-i" "5";
      "XF86AudioLowerVolume".action = spawn "pamixer" "-d" "5";
      "XF86AudioMute".action = spawn "pamixer" "-t";
      "XF86AudioMicMute".action = spawn "micmute";

      "XF86MonBrightnessUp".action = spawn "brightnessctl" "set" "+5%";
      "XF86MonBrightnessDown".action = spawn "brightnessctl" "set" "5%-";

      "Super+WheelScrollDown".action = focus-workspace-down;
      "Super+WheelScrollDown".cooldown-ms = 500;
      "Super+WheelScrollUp".action = focus-workspace-up;
      "Super+WheelScrollUp".cooldown-ms = 500;
      "Super+WheelScrollRight".action = focus-column-right;
      "Super+WheelScrollLeft".action = focus-column-left;

      "Super+H".action = focus-column-left;
      "Super+L".action = focus-column-right;
      "Super+J".action = focus-workspace-down;
      "Super+K".action = focus-workspace-up;
      "Super+Left".action = focus-column-left;
      "Super+Right".action = focus-column-right;
      "Super+Down".action = focus-window-down;
      "Super+Up".action = focus-window-up;

      "Super+Ctrl+H".action = move-column-left;
      "Super+Ctrl+J".action = move-window-down;
      "Super+Ctrl+K".action = move-window-up;
      "Super+Ctrl+L".action = move-column-right;

      "Super+U".action = move-workspace-down;
      "Super+I".action = move-workspace-up;

      "Super+Minus".action = set-column-width "-10%";
      "Super+Equal".action = set-column-width "+10%";
      "Super+Shift+Minus".action = set-window-height "-10%";
      "Super+Shift+Equal".action = set-window-height "+10%";

      "Super+Shift+H".action = focus-monitor-left;
      "Super+Shift+J".action = focus-monitor-down;
      "Super+Shift+K".action = focus-monitor-up;
      "Super+Shift+L".action = focus-monitor-right;

      "Super+Shift+Ctrl+H".action = move-column-to-monitor-left;
      "Super+Shift+Ctrl+J".action = move-column-to-monitor-down;
      "Super+Shift+Ctrl+K".action = move-column-to-monitor-up;
      "Super+Shift+Ctrl+L".action = move-column-to-monitor-right;

      "Super+R".action = switch-preset-column-width;
      "Super+F".action = maximize-column;
      "Super+Shift+F".action = fullscreen-window;
      "Super+C".action = center-column;

      "Mod+Q".action = close-window;
    };

    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/pics/ss/ss%Y-%m-%d %H-%M-%S.png";
  };
}
