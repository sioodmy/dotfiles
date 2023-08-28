{
  config,
  lib,
  pkgs,
  ...
}: let
  # thanks vi-tality
  propaganda = pkgs.writeTextFile {
    name = "propaganda";
    text = ''
      Nix advantages:
      - Correct and complete packaging
      - Immutable & reproducible results
      - Easy to cross and static compile
      - Source-based (you can alter packages without forking anything)
      - Single package manager to rule them all! (C, Python, Docker, NodeJS, etc)
      - Great for development, easily switches between dev envs with direnv
      - Easy to try out packages without installing using `nix shell` or `nix run`
        - allows to create scripts that can do and depend on anything, so long as the host has nix, it'll download things automatically for them
      - Uses binary caches so you almost never need to compile anything
      - Easy to set up a binary cache
      - Easy to set up remote building
      - Excellent testing infrastructure
      - Portable - runs on Linux and macOS
      - Can be built statically and run anywhere without root permissions
      - Mix and match different package versions without conflicts
      - Flakes let you pin versions to specific revisions

      NixOS advantages:
      - Declarative configuration
        - Meaning easier to configure your system(s)
        - Easier to change, manage and maintain the configuration
        - Easier to back up and share with people
      - Easy to deploy machines and their configuration
      - Out of the box Rollbacks.
      - Configuration options for many programs & services
      - Free of side effects - Actually uninstalls packages and their dependencies
      - Easy to set up VMs
      - People can test each other's configurations using `nix run` and `nix shell` by just having access to the source
    '';
  };
  pointer = config.home.pointerCursor;
in {
  # mostly borrwed from https://github.com/fufexan/dotfiles/blob/main/home/wayland/hyprland/config.nix (and raf)
  # thanks fufie <3
  wayland.windowManager.hyprland = {
    settings = {
      # define the mod key
      "$MOD" = "SUPER";

      exec-once = [
        # set cursor for HL itself
        "hyprctl setcursor ${pointer.name} ${toString pointer.size}"

        # bar
        "run-as-service waybar"

        # foot terminal server
        "${lib.optionalString config.programs.foot.server.enable ''run-as-service 'foot --server''}"
      ];

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
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
        border_size = 3;

        # active border color
        "col.active_border" = "rgb(89b4fa) rgb(cba6f7) 270deg";
        "col.group_border_active" = "rgba(88888888)";
        "col.group_border" = "rgba(00000088)";

        # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
        apply_sens_to_raw = 0;
      };

      decoration = {
        # fancy corners
        rounding = 7;
        multisample_edges = true; # fixes pixelated corners on relatively better monitors, useless on old monitors

        # blur
        blur = {
          enabled = true;
          size = 4;
          passes = 3;
          ignore_opacity = true;
          new_optimizations = 1;
          xray = true;
          contrast = 0.7;
          brightness = 0.8;
        };

        # shadow config
        drop_shadow = "yes";
        shadow_range = 20;
        shadow_render_power = 5;
        "col.shadow" = "rgba(292c3cee)";
      };

      misc = {
        # disable redundant renders
        disable_hyprland_logo = true; # wallpaper covers it anyway
        disable_splash_rendering = true; # "

        # window swallowing
        enable_swallow = true; # hide windows that spawn other windows
        swallow_regex = "foot|thunar|nemo"; # windows for which swallow is applied

        # dpms
        mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
        key_press_enables_dpms = true; # enable dpms on keyboard action
        disable_autoreload = true; # autoreload is unnecessary on nixos, because the config is readonly anyway

        # groupbar stuff
        # this removes the ugly gradient around grouped windows - which sucks
        groupbar_titles_font_size = 13;
        groupbar_gradients = false;
      };

      animations = {
        enabled = true; # we want animations, half the reason why we're on Hyprland innit

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

        "$MODSHIFT,S,exec,grimblast --notify --cursor copysave area" # screenshot and then pipe it to swappy

        "$MODSHIFT,L,exec,gtklock" # lock screen
      ];

      bindm = [
        "$MOD,mouse:272,movewindow"
        "$MOD,mouse:273,resizewindow"
      ];

      binde = [
        # volume controls
        ",XF86AudioRaiseVolume, exec, volume -i 5"
        ",XF86AudioLowerVolume, exec, volume -d 5"
        ",XF86AudioMute, exec, volume -t"

        # brightness controls
        ",XF86MonBrightnessUp,exec,brightness set +5%"
        ",XF86MonBrightnessDown,exec,brightness set 5%-"
      ];
      # binds that are locked, a.k.a will activate even while an input inhibitor is active
      bindl = [
        # media controls
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioPrev,exec,playerctl previous"
        ",XF86AudioNext,exec,playerctl next"
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

        # telegram media viewer
        "float, title:^(Media viewer)$"

        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit focus,class:foot"

        "idleinhibit fullscreen, class:^(firefox)$"
        "float,title:^(Firefox — Sharing Indicator)$"
        "move 0 0,title:^(Firefox — Sharing Indicator)$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

        "float,class:udiskie"

        # pavucontrol
        "float,class:pavucontrol"
        "float,title:^(Volume Control)$"
        "size 800 600,title:^(Volume Control)$"
        "move 75 44%,title:^(Volume Control)$"
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
      monitor=DP-1,1920x1080@144,0x0,1shad
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
}
