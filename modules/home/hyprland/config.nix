{
  config,
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
in {
  # mostly borrwed from https://github.com/fufexan/dotfiles/blob/main/home/wayland/hyprland/config.nix
  # thanks fufie <3
  wayland.windowManager.hyprland.extraConfig = ''
    monitor=DP-1,1920x1080@144,0x0,1shad

    $mod = SUPER

    env = _JAVA_AWT_WM_NONREPARENTING,1
    env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

    exec-once = eww open bar

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
        gaps_out=11
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
        animate_mouse_windowdragging = false
        mouse_move_enables_dpms=true
        key_press_enables_dpms=true
        disable_hyprland_logo=true
        disable_splash_rendering=true
        enable_swallow=true
        swallow_regex=foot|thunar
    }

    decoration {
        rounding=12
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

    # only allow shadows for floating windows
    windowrulev2 = noshadow, floating:0

    windowrulev2 = workspace special silent, title:^(Firefox — Sharing Indicator)$
    windowrulev2 = workspace special silent, title:^(.*is sharing (your screen|a window)\.)$
    windowrulev2 = float, title:(?i)metamask
    windowrulev2 = center, title:(?i)metamask
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
    layerrule = blur, bar
    layerrule = ignorezero, bar
    layerrule = blur, ^(gtk-layer-shell|anyrun)$
    layerrule = ignorezero, ^(gtk-layer-shell|anyrun)$



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
    bind=$mod,RETURN,exec,foot
    bind=$mod,C,killactive,
    bind=$mod,G,changegroupactive,
    bind=$mod,T,togglegroup,
    bind=$mod SHIFT,L,exec,swaylock
    bind=$mod,V,togglefloating,
    bind=$mod,F,fullscreen,
    bind=$mod,SPACE,exec,anyrun
    bind=$mod SHIFT,O,exec, ocr
    bind=$mod,P,pseudo,

    bind=$mod SHIFT,P,exec,$disable; grim - | wl-copy --type image/png && notify-send "Screenshot" "Screenshot copied to clipboard"; $enable
    bind=$mod SHIFT,S,exec,$disable; screenshot; $enable

    bind=$mod SHIFT,H,exec,cat ${propaganda} | wl-copy && notify-send "Propaganda" "ready to spread!"

    bind=$mod,h,movefocus,l
    bind=$mod,l,movefocus,r
    bind=$mod,k,movefocus,u
    bind=$mod,j,movefocus,d

    ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}
    bind=$mod SHIFT,right,movetoworkspace,+1
    bind=$mod SHIFT,left,movetoworkspace,-1


    # cycle workspaces
    bind = $mod, bracketleft, workspace, m-1
    bind = $mod, bracketright, workspace, m+1

    # cycle monitors
    bind = $mod SHIFT, braceleft, focusmonitor, l
    bind = $mod SHIFT, braceright, focusmonitor, r

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

  '';
}
