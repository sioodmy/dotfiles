{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
in {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    sh = spawn "sh" "-c";
    run = x: spawn "run-as-service" (builtins.toString (getExe x));
  in
    {
      "Mod+Return" = {
        action = run config.programs.foot.package;
        cooldown-ms = 500;
      };
      "Mod+Space".action = run config.programs.fuzzel.package;
      "Mod+V".action = sh "${pkgs.cliphist}/bin/cliphist list | fuzzel --dmenu | cliphist decode | wl-copy";
      "Mod+semicolon".action = spawn "emoji";
      "Mod+Shift+L".action = sh "niri msg action power-off-monitors; gtklock";

      "XF86AudioRaiseVolume".action = spawn "pamixer" "-i" "5";
      "XF86AudioLowerVolume".action = spawn "pamixer" "-d" "5";
      "XF86AudioMute".action = spawn "pamixer" "-t";
      "XF86AudioMicMute".action = spawn "micmute";

      "XF86Bluetooth".action = spawn "bcn";

      "XF86MonBrightnessUp".action = spawn "brightnessctl" "set" "+5%";
      "XF86MonBrightnessDown".action = spawn "brightnessctl" "set" "5%-";

      "Mod+Period".action = expel-window-from-column;
      "Mod+Comma".action = consume-window-into-column;

      "Mod+WheelScrollDown".action = focus-workspace-down;
      "Mod+WheelScrollDown".cooldown-ms = 500;
      "Mod+WheelScrollUp".action = focus-workspace-up;
      "Mod+WheelScrollUp".cooldown-ms = 500;
      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action = focus-column-left;

      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+J".action = focus-workspace-down;
      "Mod+K".action = focus-workspace-up;
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Down".action = focus-window-down;
      "Mod+Up".action = focus-window-up;

      "Mod+Print".action = screenshot-window;
      "Mod+Shift+Print".action = screenshot-screen;
      "Mod+Shift+S".action = screenshot;

      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+J".action = move-window-down;
      "Mod+Ctrl+K".action = move-window-up;
      "Mod+Ctrl+L".action = move-column-right;

      "Mod+U".action = move-workspace-down;
      "Mod+I".action = move-workspace-up;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+Shift+J".action = focus-monitor-down;
      "Mod+Shift+K".action = focus-monitor-up;

      "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

      "Mod+R".action = switch-preset-column-width;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+C".action = center-column;

      "Mod+Q".action = close-window;

      "Mod+Shift+P".action = power-off-monitors;
    }
    // (lib.attrsets.mergeAttrsList (
      map (x: let
        xStr = builtins.toString x;
      in {
        "Mod+${xStr}".action = focus-workspace x;
        "Mod+Shift+${xStr}".action = move-column-to-workspace x;
      })
      (builtins.genList (x: x + 1) 9)
    ));
}
