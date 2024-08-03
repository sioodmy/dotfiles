{pkgs, ...}: let
  inherit (builtins) concatStringsSep map;
  inherit (pkgs.lib) getExe;
  binds-normal = [
    "Super+Shift Return spawn foot"
    "None XF86Favorites spawn infoscript"
    "None XF86Display spawn gtklock"
    "None XF86Keyboard spawn 'launcher -show emoji'"
    "Super Space spawn 'launcher -show drun'"
    "Super+Shift S spawn '${getExe pkgs.slurp} | ${getExe pkgs.grim} -g - - | ${pkgs.wl-clipboard}/bin/wl-copy'"

    "Super Q close"

    # focus windows
    "Super J focus-view next"
    "Super K focus-view previous"

    "Super+Shift J swap next"
    "Super+Shift J swap previous"

    # yoinks focused view into top of layout stack
    "Super Return zoom"

    "Super H send-layout-cmd rivertile 'main-ratio -0.05'"
    "Super L send-layout-cmd rivertile 'main-ratio +0.05'"

    "Super+Shift H send-layout-cmd rivertile 'main-count +1'"
    "Super+Shift L send-layout-cmd rivertile 'main-count -1'"

    # move floating windows around
    "Super+Alt H move left 50"
    "Super+Alt J move down 50"
    "Super+Alt K move up 50"
    "Super+Alt L move right 50"

    # resize floating windows
    "Super+Alt+Shift H resize horizontal -50"
    "Super+Alt+Shift J resize vertical 50"
    "Super+Alt+Shift K resize vertical -50"
    "Super+Alt+Shift L resize horizontal -50"

    "Super V toggle-float"
    "Super F toggle-fullscreen"

    "Super Up send-layout-cmd rivertile 'main-location top'"
    "Super Right send-layout-cmd rivertile 'main-location right'"
    "Super Down send-layout-cmd rivertile 'main-location bottom'"
    "Super Left send-layout-cmd rivertile 'main-location left'"
  ];
in
  pkgs.writeShellScript "river-init-binds" ''
     #!/bin/sh

     ${concatStringsSep "\n"
      (map
        (
          bind: "riverctl map normal ${bind}"
        )
        binds-normal)}

    # Super + Left Mouse Button to move views
    riverctl map-pointer normal Super BTN_LEFT move-view

    # Super + Right Mouse Button to resize views
    riverctl map-pointer normal Super BTN_RIGHT resize-view

    for i in $(seq 1 9)
    do
        tags=$((1 << ($i - 1)))

        riverctl map normal Super $i set-focused-tags $tags

        # Super+Shift+[1-9] to tag focused view with tag [0-8]
        riverctl map normal Super+Shift $i set-view-tags $tags

        # Super+Control+[1-9] to toggle focus of tag [0-8]
        riverctl map normal Super+Control $i toggle-focused-tags $tags

        # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
        riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
    done


    for mode in normal locked
    do
        riverctl map $mode None XF86AudioRaiseVolume  spawn 'mako-osd volume up'
        riverctl map $mode None XF86AudioLowerVolume  spawn 'mako-osd volume down'
        riverctl map $mode None XF86AudioMute         spawn 'mako-osd volume mute'

        riverctl map $mode None XF86MonBrightnessUp   spawn 'mako-osd backlight up'
        riverctl map $mode None XF86MonBrightnessDown spawn 'mako-osd backlight down'
    done


  ''
