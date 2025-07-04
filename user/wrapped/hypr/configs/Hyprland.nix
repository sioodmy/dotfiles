theme: let
  mod = "Super";

  # credits: fufexan
  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "${mod}, ${ws}, workspace, ${toString (x + 1)}"
        "${mod} SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);
in {
  env = [
    "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
  ];
  exec-once = [
    "swaybg -i ${theme.wallpaper}"
    "hyprsunset -t 4000"
    "hypridle"
    "mako"
    "waybar"
  ];
  general = {
    gaps_in = 5;
    gaps_out = 5;
    border_size = 2;
    "col.active_border" = "rgb(${theme.accent})";
    "col.inactive_border" = "rgb(${theme.regular.background})";

    allow_tearing = true;
    resize_on_border = true;
  };

  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };
  misc = {
    disable_autoreload = true;
    force_default_wallpaper = 0;
    animate_mouse_windowdragging = false;
    swallow_regex = "^(Alacritty|kitty|footclient|foot)$";
    enable_swallow = true;
    vrr = 1;
  };
  xwayland.force_zero_scaling = true;

  debug.disable_logs = false;

  decoration = {
    rounding = 0;
    blur = {
      enabled = true;
      brightness = 1.0;
      contrast = 1.0;
      noise = 0.01;

      vibrancy = 0.2;
      vibrancy_darkness = 0.5;

      passes = 4;
      size = 7;

      popups = true;
      popups_ignorealpha = 0.2;
    };

    shadow = {
      enabled = true;
      color = "rgba(2e2e2e2e)";
      ignore_window = true;
      offset = "2 4";
      range = 15;
      render_power = 2;
    };
  };

  animations = {
    enabled = true;
    animation = [
      "border, 1, 2, default"
      "fade, 1, 4, default"
      "windows, 1, 3, default, popin 80%"
      "workspaces, 1, 2, default, slidevert"
    ];
  };

  input = {
    kb_layout = "pl";
    kb_options = "caps:escape";

    follow_mouse = 1;
    accel_profile = "flat";
    tablet.output = "current";
    touchpad = {
      clickfinger_behavior = true;
      scroll_factor = 0.1;
      natural_scroll = true;
    };
  };
  gestures = {
    workspace_swipe = true;
    workspace_swipe_distance = 200;
    workspace_swipe_invert = 1;
    workspace_swipe_min_speed_to_force = 20;
    workspace_swipe_cancel_ratio = 0.5;
  };

  bindl = [
    # media controls
    ", XF86AudioPlay, exec, playerctl play-pause"
    ", XF86AudioPrev, exec, playerctl previous"
    ", XF86AudioNext, exec, playerctl next"

    # volume
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
  ];
  bindr = [
    # launcher
    "${mod}, Space, exec, anyrun"
    ", XF86Search, exec, anyrun"
  ];
  bindle = [
    # volume
    ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
    ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

    # backlight
    ", XF86MonBrightnessUp, exec, brillo -q -A 5"
    ", XF86MonBrightnessDown, exec, brillo -q -U 5"
    "${mod}, XF86MonBrightnessUp, exec, keylit"
    "${mod}, XF86MonBrightnessDown, exec, keylit"
  ];
  bindm = [
    "${mod}, mouse:272, movewindow"
    "${mod}, Control_L, movewindow"
    "${mod}, mouse:273, resizewindow"
    "${mod}, ALT_L, resizewindow"
  ];
  bind =
    [
      "${mod}, minus, killactive"
      "${mod}, F, fullscreen,"
      "${mod}, G, togglegroup,"
      "${mod} SHIFT, N, changegroupactive, f"
      "${mod} SHIFT, P, changegroupactive, b"
      "${mod}, R, togglesplit,"
      "${mod}, T, togglefloating,"
      "${mod}, P, pseudo,"
      "${mod} ALT, ,resizeactive,"

      "${mod}, Return, exec, foot -e tmux"
      "${mod} SHIFT, L, exec, hyprlock"

      "${mod}, h, movefocus, l"
      "${mod}, l, movefocus, r"
      "${mod}, k, movefocus, u"
      "${mod}, j, movefocus, d"

      "${mod} SHIFT, s, exec, grimblast --notify copy area"

      "${mod}, bracketleft, workspace, m-1"
      "${mod}, bracketright, workspace, m+1"

      "${mod} SHIFT, bracketleft, focusmonitor, l"
      "${mod} SHIFT, bracketright, focusmonitor, r"

      "${mod} SHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
      "${mod} SHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"
    ]
    ++ workspaces;

  layerrule = [
    "blur, anyrun"
    " ignorealpha 0.6, anyrun"
  ];
  windowrulev2 = [
    "workspace 2, class:(firefox|librewolf|brave)"
    "workspace 4 silent, class:(signal|vesktop)"
    "suppressevent maximize, class:.*"
    "scrolltouchpad 0.23, class:^(zen|firefox|brave|chromium-browser|chrome-.*)$"
    "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
  ];
}
