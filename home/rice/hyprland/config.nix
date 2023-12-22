{
  config,
  lib,
  ...
}: let
  pointer = config.home.pointerCursor;
in {
  # mostly borrwed from https://github.com/fufexan/dotfiles/blob/main/home/wayland/hyprland/config.nix (and raf)
  # thanks fufie <3
  wayland.windowManager.hyprland = {
    settings = {
      # define the mod key
      "$MOD" = "SUPER";
      "$scratchpad" = "title:^.*scratchpad.*$";
      "$spotify" = "title:^.*scratchpad-spotify.*$";
      "$pavucontrol" = "class:^(pavucontrol)$";

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        # set cursor for HL itself
        "hyprctl setcursor ${pointer.name} ${toString pointer.size}"

        # bar
        "run-as-service waybar"

        # foot terminal server
        "${lib.optionalString config.programs.foot.server.enable ''run-as-service 'foot --server''}"

        # scratchpads
        "run-as-service pypr"

        # dirty fix for spotifyd
        "systemctl --user restart spotifyd.service"
      ];

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        # keyboard layout
        kb_layout = "pl";
        kb_options = "caps:escape";
        # self explanatory, I hope?
        follow_mouse = 1;
        # do not imitate natural scroll
        touchpad.natural_scroll = "no";
      };

      general = {
        # sensitivity of the mouse cursor
        sensitivity = 0.6;

        # gaps
        gaps_in = 6;
        gaps_out = 11;

        # border thiccness
        border_size = 2;

        # active border color
        "col.active_border" = "rgb(89b4fa) rgb(cba6f7) 270deg";

        # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
        apply_sens_to_raw = 0;
      };

      decoration = {
        # fancy corners
        rounding = 7;

        # blur
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = 1;
          xray = true;
          contrast = 0.7;
          brightness = 0.8;
        };

        # shadow config
        drop_shadow = "no";
        shadow_range = 20;
        shadow_render_power = 5;
        "col.shadow" = "rgba(292c3cee)";
      };

      misc = {
        # disable redundant renders
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;

        vfr = true;

        # window swallowing
        enable_swallow = true; # hide windows that spawn other windows
        swallow_regex = "foot|footclient"; # windows for which swallow is applied

        # dpms
        mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
        key_press_enables_dpms = true; # enable dpms on keyboard action
        disable_autoreload = true; # autoreload is unnecessary on nixos, because the config is readonly anyway
      };

      animations = {
        enabled = true;
        first_launch_animation = false;

        bezier = [
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          "overshot, 0.4,0.8,0.2,1.2"
        ];

        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "border,1,10,default"

          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces,1,4,overshot,slidevert"
        ];
      };

      dwindle = {
        pseudotile = false;
        preserve_split = "yes";
        no_gaps_when_only = false;
      };

      "$kw" = "dwindle:no_gaps_when_only";

      bind = [
        ''$MOD,RETURN,exec,run-as-service footclient''

        "$MOD,SPACE,exec,anyrun"
        "$MOD,C,killactive"
        "$MOD,P,pseudo"

        # scratchpads
        "ALT,code:9,exec, pypr toggle term && hyprctl dispatch bringactivetotop"
        "$MOD,B,exec, pypr toggle btm && hyprctl dispatch bringactivetotop"
        "$MOD,code:61,exec,pypr toggle spotify && hyprctl dispatch bringactivetotop"
        "$MOD,code:21,exec,pypr zoom"
        "$MOD,code:21,exec,hyprctl reload"

        "$MOD,H,movefocus,l"
        "$MOD,L,movefocus,r"
        "$MOD,K,movefocus,u"
        "$MOD,J,movefocus,d"

        "$MOD,M,exec,hyprctl keyword $kw $(($(hyprctl getoption $kw -j | jaq -r '.int') ^ 1))" # toggle no_gaps_when_only
        "$MOD,T,togglegroup," # group focused window
        "$MODSHIFT,G,changegroupactive," # switch within the active group
        "$MOD,V,togglefloating," # toggle floating for the focused window
        "$MOD,F,fullscreen," # fullscreen focused window

        # workspace controls
        "$MODSHIFT,right,movetoworkspace,+1" # move focused window to the next ws
        "$MODSHIFT,left,movetoworkspace,-1" # move focused window to the previous ws
        "$MOD,mouse_down,workspace,e+1" # move to the next ws
        "$MOD,mouse_up,workspace,e-1" # move to the previous ws

        "$MOD,Print,exec, pauseshot"
        ",Print,exec, grim - | wl-copy"
        "$MODSHIFT,O,exec,wl-ocr"

        "$MODSHIFT,L,exec,gtklock" # lock screen
      ];

      bindm = [
        "$MOD,mouse:272,movewindow"
        "$MOD,mouse:273,resizewindow"
      ];

      binde = [
        # volume controls
        ",XF86AudioRaiseVolume, exec, pamixer -i 5"
        ",XF86AudioLowerVolume, exec, pamixer -d 5"
        ",XF86AudioMute, exec, pamixer -t"
        ",XF86AudioMicMute, exec, micmute"

        # brightness controls
        ",XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        "SUPERALT, L, resizeactive, 80 0"
        "SUPERALT, H, resizeactive, -80 0"
      ];
      # binds that are locked, a.k.a will activate even while an input inhibitor is active
      bindl = [
        # media controls
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioPrev,exec,playerctl previous"
        ",XF86AudioNext,exec,playerctl next"
      ];
      workspace = [
        "1, monitor:eDP-1"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
        "6, monitor:HDMI-A-1"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
      ];
      layerrule = [
        "blur, ^(gtk-layer-shell)$"
        "ignorezero, ^(gtk-layer-shell)$"
        "blur, notifications"
        "ignorezero, notifications"
        "blur, bar"
        "ignorezero, bar"
        "ignorezero, ^(gtk-layer-shell|anyrun)$"
        "blur, ^(gtk-layer-shell|anyrun)$"
      ];
      windowrulev2 = [
        # only allow shadows for floating windows
        "noshadow, floating:0"
        "tile, title:Spotify"
        "fullscreen,class:wlogout"
        "fullscreen,title:wlogout"

        # scratchpad
        "float,$scratchpad"
        "size 80% 85%,$scratchpad"
        "workspace special silent,$scratchpad"
        "center,$scratchpad"

        "bordercolor rgb(a6e3a1),$spotify"
        "bordersize 4,$spotify"

        # telegram media viewer
        "float, title:^(Media viewer)$"

        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit focus,class:foot"

        "idleinhibit fullscreen, class:^(firefox)$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

        "float,class:udiskie"

        "opacity 0.85 0.85,class:^(firefox)$"
        "opacity 0.8 0.8,class:^(org.keepassxc.KeePassXC)$"

        # pavucontrol
        "float,$pavucontrol"
        "size 86% 40%,$pavucontrol"
        "move 50% 6%,$pavucontrol"
        "workspace special silent,$pavucontrol"
        "opacity 0.80,$pavucontrol"

        "opacity 0.80,title:^(Spotify)$"

        "opacity 0.9,class:^(org.keepassxc.KeePassXC)$"

        "float, class:^(imv)$"

        # throw sharing indicators away
        "workspace special silent, title:^(Firefox — Sharing Indicator)$"
        "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

        "workspace 4, title:^(.*(Disc|WebC)ord.*)$"
        "tile, class:^(Spotify)$"
        "workspace 3, title:^(Spotify)$"
        "workspace 2, class:^(firefox)$"

        "workspace 10 silent, class:^(Nextcloud)$"
      ];
    };
    extraConfig = ''
      monitor=,highrr,auto,1
      monitor=eDP-1,1920x1080,0x0,1
      monitor=HDMI-A-1,1920x1080@144,0x-1080,1

      # a submap for resizing windows
      bind = $MOD, S, submap, resize # enter resize window to resize the active window

      submap=resize
      binde=,right,resizeactive,10 0
      binde=,left,resizeactive,-10 0
      binde=,up,resizeactive,0 -10
      binde=,down,resizeactive,0 10
      bind=,escape,submap,reset
      submap=reset

      # workspace binds
      # binds * (asterisk) to special workspace
      bind = $MOD, KP_Multiply, togglespecialworkspace
      bind = $MODSHIFT, KP_Multiply, movetoworkspace, special

      # and mod + [shift +] {1..10} to [move to] ws {1..10}
      ${
        builtins.concatStringsSep
        "\n"
        (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in ''
              bind = $MOD, ${ws}, workspace, ${toString (x + 1)}
              bind = $MOD SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
            ''
          )
          10)
      }

    '';
  };

  xdg.configFile."hypr/pyprland.json".text = builtins.toJSON {
    pyprland = {
      plugins = ["scratchpads" "magnify"];
    };
    scratchpads = {
      term = {
        command = "foot --title scratchpad";
        margin = 50;
        unfocus = "hide";
        animation = "fromTop";
      };
      btm = {
        command = "foot --title scratchpad -e btm";
        margin = 50;
        unfocus = "hide";
        animation = "fromTop";
      };
      spotify = {
        command = "foot --title scratchpad-spotify -e sh -c 'systemctl --user restart spotifyd; sleep 1; spt'";
        margin = 50;
        unfocus = "hide";
        animation = "fromTop";
      };
    };
  };
}
