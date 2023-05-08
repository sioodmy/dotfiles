{
  config,
  pkgs,
  ...
}: let
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
in {
  wayland.windowManager.hyprland.extraConfig = ''
    monitor=DP-1,1920x1080@144,0x0,1shad


    input {
        kb_layout=pl
        kb_options=caps:escape

        follow_mouse=1

        touchpad {
            natural_scroll=no
        }
    }

    general {
        sensitivity=0.6 # for mouse cursor

        gaps_in=5
        gaps_out=5
        border_size=2
        col.active_border = rgb(89b4fa) rgb(cba6f7) 270deg
        col.inactive_border = rgb(11111b) rgb(b4befe) 270deg

        col.group_border = rgb(313244)
        col.group_border_active = rgb(f5c2e7)


        apply_sens_to_raw=0
    }

    misc {
        disable_hyprland_logo=true
        disable_splash_rendering=true
        mouse_move_enables_dpms=true
        key_press_enables_dpms=true
        disable_hyprland_logo=true
        disable_splash_rendering=true
        enable_swallow=true
        swallow_regex=foot|thunar
    }

    decoration {
        rounding=16
        multisample_edges=true
        blur_new_optimizations=1
        blur=1
        blur_size=3
        blur_passes=3

        drop_shadow = true
        shadow_ignore_window = true
        shadow_offset = 0 5
        shadow_range = 50
        shadow_render_power = 3
        col.shadow = rgba(00000099)
    }


    animations {
        enabled = true

        bezier = smoothOut, 0.36, 0, 0.66, -0.56
        bezier = smoothIn, 0.25, 1, 0.5, 1
        bezier = overshot, 0.4, 0.8, 0.2, 1.2

        animation = windows, 1, 4, overshot, slide
        animation = windowsOut, 1, 4, smoothOut, slide
        animation = border, 1, 10, default
        animation = fade, 1, 3, smoothIn
        animation = fadeDim, 1, 3, smoothIn
        animation=workspaces,1,4,overshot,slidevert
    }

    dwindle {
        pseudotile = false
        preserve_split = yes
        no_gaps_when_only = false
    }

    gestures {
        workspace_swipe=yes
    }

    $disable=act_opa=$(hyprctl getoption "decoration:active_opacity" -j | jq -r ".float");inact_opa=$(hyprctl getoption "decoration:inactive_opacity" -j | jq -r ".float");hyprctl --batch "keyword decoration:active_opacity 1;keyword decoration:inactive_opacity 1"
    $enable=hyprctl --batch "keyword decoration:active_opacity $act_opa;keyword decoration:inactive_opacity $inact_opa"

    windowrulev2 = workspace special silent, title:^(Firefox — Sharing Indicator)$
    windowrulev2 = workspace special silent, title:^(.*is sharing (your screen|a window)\.)$

    windowrulev2 = idleinhibit focus, class:^(mpv|.+exe)$
    windowrulev2 = idleinhibit focus, class:^(firefox|brave)$, title:^(.*YouTube.*)$
    windowrulev2 = idleinhibit fullscreen, class:^(firefox|brave)$

    windowrulev2 = rounding 0, xwayland:1, floating:1
    windowrulev2 = center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$
    windowrulev2 = size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$

    layerrule = blur, ^(gtk-layer-shell)$
    layerrule = ignorezero, ^(gtk-layer-shell)$
    layerrule = blur, notifications
    layerrule = ignorezero, notifications



    windowrule=tile,title:Spotify
    windowrule=float,*.exe
    windowrule=fullscreen,wlogout
    windowrule=float,title:wlogout
    windowrule=float,udiskie
    windowrule=fullscreen,title:wlogout
    windowrule=float,pavucontrol-qt
    windowrule=float,qalculate-gtk
    windowrulev2 = opacity 0.7 override 0.7 override,class:^(qualculate-gtk)$
    windowrule=float,qalculate-qt
    windowrule=nofullscreenrequest,class:firefox
    windowrule=idleinhibit focus,mpv
    windowrule=idleinhibit fullscreen,firefox

    windowrule=float,title:^(Media viewer)$
    windowrule=float,title:^(Transmission)$
    windowrule=float,title:^(Volume Control)$
    windowrule=float,title:^(Picture-in-Picture)$
    windowrule=float,title:^(Firefox — Sharing Indicator)$
    windowrule=move 0 0,title:^(Firefox — Sharing Indicator)$

    windowrule=size 800 600,title:^(Volume Control)$
    windowrule=move 75 44%,title:^(Volume Control)$

    # example binds
    bind=SUPER,RETURN,exec,run-as-service footclient
    bind=SUPER,C,killactive,
    bind=SUPER,G,changegroupactive,
    bind=SUPER,T,togglegroup,
    bind=SUPER,M,exit,
    bind=SUPER,E,exec,dolphin
    bind=SUPERSHIFT,L,exec,swaylock
    bind=SUPER,V,togglefloating,
    bind=SUPER,F,fullscreen,
    bind=SUPER,SPACE,exec,anyrun
    bind=SUPERSHIFT,O,exec, ocr
    bind=SUPER,P,pseudo,

    bind=SUPERSHIFT,P,exec,$disable; grim - | wl-copy --type image/png && notify-send "Screenshot" "Screenshot copied to clipboard"; $enable
    bind=SUPERSHIFT,S,exec,$disable; screenshot; $enable

    bind=SUPERSHIFT,H,exec,cat ${propaganda} | wl-copy && notify-send "Propaganda" "ready to spread!"

    bind=SUPER,h,movefocus,l
    bind=SUPER,l,movefocus,r
    bind=SUPER,k,movefocus,u
    bind=SUPER,j,movefocus,d

    bind=SUPER,1,workspace,1
    bind=SUPER,2,workspace,2
    bind=SUPER,3,workspace,3
    bind=SUPER,4,workspace,4
    bind=SUPER,5,workspace,5
    bind=SUPER,6,workspace,6
    bind=SUPER,7,workspace,7
    bind=SUPER,8,workspace,8
    bind=SUPER,9,workspace,9
    bind=SUPER,0,workspace,10

    # MOVING WINDOWS TO WS
    bind=SUPERSHIFT,1,movetoworkspace,1
    bind=SUPERSHIFT,2,movetoworkspace,2
    bind=SUPERSHIFT,3,movetoworkspace,3
    bind=SUPERSHIFT,4,movetoworkspace,4
    bind=SUPERSHIFT,5,movetoworkspace,5
    bind=SUPERSHIFT,6,movetoworkspace,6
    bind=SUPERSHIFT,7,movetoworkspace,7
    bind=SUPERSHIFT,8,movetoworkspace,8
    bind=SUPERSHIFT,9,movetoworkspace,9
    bind=SUPERSHIFT,0,movetoworkspace,10
    bind=SUPERSHIFT,right,movetoworkspace,+1
    bind=SUPERSHIFT,left,movetoworkspace,-1

    bind=SUPER,mouse_down,workspace,e+1
    bind=SUPER,mouse_up,workspace,e-1

    bind=,XF86MonBrightnessUp,exec,brightnessctl set +5%
    bind=,XF86MonBrightnessDown,exec,brightnessctl set 5%-

    binde = SUPERALT, L, resizeactive, 80 0
    binde = SUPERALT, H, resizeactive, -80 0
    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    # Volume keys
    binde=, XF86AudioRaiseVolume, exec, volume -i 5
    bindl=, XF86AudioLowerVolume, exec, volume -d 5
    bindl=, XF86AudioMute, exec, volume -t

    exec-once = run-as-service 'foot --server'
    exec-once = run-as-service waybar
  '';
}
