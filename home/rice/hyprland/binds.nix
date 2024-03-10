{
  config,
  lib,
  ...
}: let
  mod = "SUPER";
  modshift = "${mod}SHIFT";

  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10} (stolen from fufie)
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
  wayland.windowManager.hyprland.settings = {
    bind =
      [
        ''${mod},RETURN,exec,run-as-service foot${lib.optionalString config.programs.foot.server.enable "client"}''

        "${mod},SPACE,exec,run-as-service $(tofi-drun)"
        "${mod},MINUS,killactive"
        "${mod},P,pseudo"

        "${mod},H,movefocus,l"
        "${mod},L,movefocus,r"
        "${mod},K,movefocus,u"
        "${mod},J,movefocus,d"

        ",XF86Bluetooth, exec, bcn"
        "${mod},M,exec,hyprctl keyword $kw $(($(hyprctl getoption $kw -j | jaq -r '.int') ^ 1))" # toggle no_gaps_when_only
        "${mod},T,togglegroup," # group focused window
        "${modshift},G,changegroupactive," # switch within the active group
        "${mod},V,togglefloating," # toggle floating for the focused window
        "${mod},F,fullscreen," # fullscreen focused window

        # workspace controls
        "${modshift},right,movetoworkspace,+1" # move focused window to the next ws
        "${modshift},left,movetoworkspace,-1" # move focused window to the previous ws
        "${mod},mouse_down,workspace,e+1" # move to the next ws
        "${mod},mouse_up,workspace,e-1" # move to the previous ws

        "${mod},Print,exec, pauseshot"
        ",Print,exec, grim - | wl-copy"
        "${modshift},O,exec,wl-ocr"

        "${mod},Period,exec, tofi-emoji"

        "${modshift},L,exec,hyprlock"
      ]
      ++ workspaces;

    bindm = [
      "${mod},mouse:272,movewindow"
      "${mod},mouse:273,resizewindow"
    ];

    binde = [
      # volume controls
      ",XF86AudioRaiseVolume, exec, nc -U /tmp/barbie-vol.sock; pamixer -i 5"
      ",XF86AudioLowerVolume, exec, nc -U /tmp/barbie-vol.sock; pamixer -d 5"
      ",XF86AudioMute, exec, pamixer -t"
      ",XF86AudioMicMute, exec, micmute"

      # brightness controls
      ",XF86MonBrightnessUp, exec, nc -U /tmp/barbie-bl.sock; brightnessctl set +10%"
      ",XF86MonBrightnessDown, exec, nc -U /tmp/barbie-bl.sock; brightnessctl set 10%-"
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
  };
}
