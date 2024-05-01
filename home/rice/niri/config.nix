theme:
with theme.colors; ''
  input {
      keyboard {
          xkb {
              layout "pl"
              options "caps:escape"
          }
      }

      touchpad {
          tap
          dwt
          dwtp
          natural-scroll
          click-method "clickfinger"
      }

      trackpoint {
          accel-speed 0.001
       }

      warp-mouse-to-focus
      focus-follows-mouse
      workspace-auto-back-and-forth
  }

  output "eDP-1" {
      mode "1920x1080@120.0"
      scale 1.0
      position x=0 y=0

  }

  output "DP-2" {
      scale 1.0
      mode "1920x1080@144.001"

      position x=0 y=-1080
  }

  layout {
      gaps 16

      center-focused-column "never"

      preset-column-widths {
          proportion 0.33333
          proportion 0.5
          proportion 0.66667
      }

      default-column-width { proportion 0.5; }

      focus-ring {
          width 2
          active-color "#${accent}"
          inactive-color "#${overlay0}"
      }
  }

  spawn-at-startup "systemctl" "--user" "start" "niri.target"
  // TODO: Find a better way
  spawn-at-startup "systemctl" "--user" "restart" "swaybg.service"

  prefer-no-csd

  screenshot-path "~/pics/ss/ss%Y-%m-%d %H-%M-%S.png"

  window-rule {
      match app-id="firefox"
      default-column-width { proportion 1.0;}
  }

  window-rule {
      match app-id=r#"^org\.keepassxc\.KeePassXC$"#
      match app-id=r#"^org\.gnome\.World\.Secrets$"#
      block-out-from "screen-capture"
  }

  window-rule {
      match title="Firefox — Sharing Indicator"
      max-width 0
      max-height 0
  }

  binds {
      Mod+Shift+Slash { show-hotkey-overlay; }

      // Suggested binds for running programs: terminal, app launcher, screen locker.
      Mod+Return { spawn "foot"; }
      Mod+Space { spawn "fuzzel"; }
      Super+Shift+L { spawn "swaylock"; }

      // You can also use a shell:
      // Mod+T { spawn "bash" "-c" "notify-send hello && exec alacritty"; }

      // Example volume keys mappings for PipeWire & WirePlumber.
      // The allow-when-locked=true property makes them work even when the session is locked.
      XF86AudioRaiseVolume allow-when-locked=true { spawn "pamixer" "-i" "5"; }
      XF86AudioLowerVolume allow-when-locked=true { spawn "pamixer" "-d" "5"; }
      XF86AudioMute        allow-when-locked=true { spawn "pamixer" "-t"; }
      XF86AudioMicMute     allow-when-locked=true { spawn "micmute"; }

      XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "set" "+5%"; }
      XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "5%-"; }

      Mod+Q { close-window; }

      Mod+Left  { focus-column-left; }
      Mod+Down  { focus-window-down; }
      Mod+Up    { focus-window-up; }
      Mod+Right { focus-column-right; }
      Mod+H     { focus-column-left; }
      Mod+J     { focus-window-down; }
      Mod+K     { focus-window-up; }
      Mod+L     { focus-column-right; }

      Mod+Ctrl+Left  { move-column-left; }
      Mod+Ctrl+Down  { move-window-down; }
      Mod+Ctrl+Up    { move-window-up; }
      Mod+Ctrl+Right { move-column-right; }
      Mod+Ctrl+H     { move-column-left; }
      Mod+Ctrl+J     { move-window-down; }
      Mod+Ctrl+K     { move-window-up; }
      Mod+Ctrl+L     { move-column-right; }

      // Alternative commands that move across workspaces when reaching
      // the first or last window in a column.
      // Mod+J     { focus-window-or-workspace-down; }
      // Mod+K     { focus-window-or-workspace-up; }
      // Mod+Ctrl+J     { move-window-down-or-to-workspace-down; }
      // Mod+Ctrl+K     { move-window-up-or-to-workspace-up; }

      Mod+Home { focus-column-first; }
      Mod+End  { focus-column-last; }
      Mod+Ctrl+Home { move-column-to-first; }
      Mod+Ctrl+End  { move-column-to-last; }

      Mod+Shift+Left  { focus-monitor-left; }
      Mod+Shift+Down  { focus-monitor-down; }
      Mod+Shift+Up    { focus-monitor-up; }
      Mod+Shift+Right { focus-monitor-right; }
      Mod+Shift+H     { focus-monitor-left; }
      Mod+Shift+J     { focus-monitor-down; }
      Mod+Shift+K     { focus-monitor-up; }
      Mod+Shift+L     { focus-monitor-right; }

      Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
      Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

      Mod+Page_Down      { focus-workspace-down; }
      Mod+Page_Up        { focus-workspace-up; }
      Mod+U              { focus-workspace-down; }
      Mod+I              { focus-workspace-up; }
      Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
      Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
      Mod+Ctrl+U         { move-column-to-workspace-down; }
      Mod+Ctrl+I         { move-column-to-workspace-up; }

      Mod+Shift+Page_Down { move-workspace-down; }
      Mod+Shift+Page_Up   { move-workspace-up; }
      Mod+Shift+U         { move-workspace-down; }
      Mod+Shift+I         { move-workspace-up; }

      Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
      Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
      Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
      Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

      Mod+WheelScrollRight      { focus-column-right; }
      Mod+WheelScrollLeft       { focus-column-left; }
      Mod+Ctrl+WheelScrollRight { move-column-right; }
      Mod+Ctrl+WheelScrollLeft  { move-column-left; }

      Mod+Shift+WheelScrollDown      { focus-column-right; }
      Mod+Shift+WheelScrollUp        { focus-column-left; }
      Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
      Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }
      Mod+Ctrl+1 { move-column-to-workspace 1; }
      Mod+Ctrl+2 { move-column-to-workspace 2; }
      Mod+Ctrl+3 { move-column-to-workspace 3; }
      Mod+Ctrl+4 { move-column-to-workspace 4; }
      Mod+Ctrl+5 { move-column-to-workspace 5; }
      Mod+Ctrl+6 { move-column-to-workspace 6; }
      Mod+Ctrl+7 { move-column-to-workspace 7; }
      Mod+Ctrl+8 { move-column-to-workspace 8; }
      Mod+Ctrl+9 { move-column-to-workspace 9; }

      // Alternatively, there are commands to move just a single window:
      // Mod+Ctrl+1 { move-window-to-workspace 1; }

      // Switches focus between the current and the previous workspace.
      // Mod+Tab { focus-workspace-previous; }

      Mod+Comma  { consume-window-into-column; }
      Mod+Period { expel-window-from-column; }

      // There are also commands that consume or expel a single window to the side.
      // Mod+BracketLeft  { consume-or-expel-window-left; }
      // Mod+BracketRight { consume-or-expel-window-right; }

      Mod+R { switch-preset-column-width; }
      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+C { center-column; }

      Mod+Minus { set-column-width "-10%"; }
      Mod+Equal { set-column-width "+10%"; }

      Mod+Shift+Minus { set-window-height "-10%"; }
      Mod+Shift+Equal { set-window-height "+10%"; }

      Super+Print { screenshot; }
      Ctrl+Print { screenshot-screen; }
      Alt+Print { screenshot-window; }

      Mod+Shift+P { power-off-monitors; }
  }
''
