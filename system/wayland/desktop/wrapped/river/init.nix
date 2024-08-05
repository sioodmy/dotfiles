{
  pkgs,
  colors,
  ...
}: let
  init-binds = import ./binds.nix {inherit pkgs;};
in
  pkgs.writeShellScript "river-init" ''
    #!/bin/sh

    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=river

    ${init-binds}

    TOUCHPAD="pointer-1739-52619-SYNA8004:00_06CB:CD8B_Touchpad"
    TRACKPOINT="pointer-2-10-TPPS/2_Elan_TrackPoint"

    riverctl input $TOUCHPAD pointer-accel 0.1
    riverctl input $TOUCHPAD accel-profile adaptive
    riverctl input $TOUCHPAD click-method clickfinger
    riverctl input $TOUCHPAD drag disabled
    riverctl input $TOUCHPAD natural-scroll enabled
    riverctl input $TOUCHPAD tap enabled
    riverctl input $TOUCHPAD tap-button-map left-right-middle
    riverctl input $TOUCHPAD scroll-method two-finger

    riverctl input $TRACKPOINT pointer-accel -0.3

    riverctl keyboard-layout -options "caps:escape" pl
    riverctl set-repeat 30 350

    riverctl background-color "0x${colors.base01}"
    riverctl border-color-focused "0x${colors.base04}"
    riverctl border-color-unfocused "0x${colors.base02}"

    riverctl default-layout rivertile
    rivertile -view-padding 3 -outer-padding 3 &

    mako-wrapped &
    signal-desktop &
    kanshi &

    swayidle -w \
      timeout 130 "brightnessctl s 5%" \
      timeout 135 "gtklock" \
      timeout 600 "systemctl suspend" \
      before-sleep "gtklock" \
      lock "gtklock" &
  ''
