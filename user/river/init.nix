{
  pkgs,
  theme,
  ...
}: let
  init-binds = import ./binds.nix {inherit pkgs;};
  inherit (pkgs.lib) getExe;

  # river does not support zwp_idle_inhibit_manager_v1 protocol,
  # so instead I used this oneliner combined with swayidle
  idle = x: ''"sh -c \"${getExe pkgs.playerctl} status || ${x}\""'';
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

    riverctl rule-add -title "Open As" float
    riverctl rule-add -title "Open File" float
    riverctl rule-add -title "Open Folder" float
    riverctl rule-add -title "Open" float
    riverctl rule-add -title "Save As" float
    riverctl rule-add -title "Save File" float
    riverctl rule-add -title "Save Folder" float
    riverctl rule-add -title "Save" float

    riverctl keyboard-layout -options "caps:escape" pl
    riverctl set-repeat 30 350

    riverctl background-color "0x${theme.base01}"
    riverctl border-color-focused "0x${theme.base04}"
    riverctl border-color-unfocused "0x${theme.base02}"
    riverctl border-width 4

    riverctl default-layout rivercarro
    ${getExe pkgs.rivercarro} -inner-gaps 5 -outer-gaps 3 -per-tag &

    riverctl xcursor-theme "Bibata-Modern-Classic" 18

    # TODO: Make systemd user services instead

    foot --server &
    mako &
    signal-desktop &
    kanshi &

    ${getExe pkgs.swayidle} \
      timeout 135 ${idle "swaylock --grace 5"} \
      timeout 600 ${idle "systemctl suspend"} \
      before-sleep ${idle "swaylock"} \
      lock "swaylock" &

    # your eyes and your sleep schedule will thank you
    ${getExe pkgs.wlsunset} -l 50.2597 -L 19.0211 &
  ''
