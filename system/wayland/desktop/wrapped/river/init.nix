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

    TOUCHPAD=$(riverctl list-inputs | rg Touchpad)
    TRACKPOINT=$(riverctl list-inputs | rg TrackPoint)

    riverctl input $TOUCHPAD pointer-accel 0.5
    riverctl input $TOUCHPAD accel-profile flat
    riverctl input $TOUCHPAD natural-scroll enabled
    riverctl input $TOUCHPAD click-method clickfinger
    riverctl input $TOUCHPAD tap enabled
    riverctl input $TOUCHPAD disable-when-typing enabled

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


  ''
