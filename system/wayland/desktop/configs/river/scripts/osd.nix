{pkgs, ...}: let
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
in
  pkgs.writeShellScriptBin "mako-osd" ''
    #!/bin/sh

    if [[ "$1" == "volume" ]]; then
        if [[ "$2" == "up" ]]; then
            ${pamixer} -i 5

        elif [[ "$2" == "down" ]]; then
            ${pamixer} -d 5
        elif [[ "$2" == "mute" ]]; then
            ${pamixer} -t
        fi

        TAG="vol"
        VAL="$(${pamixer} --get-volume)"
        LABEL="Volume $([[ $(${pamixer} --get-mute) == true ]] && printf '(Muted)')"

    elif [[ "$1" == "backlight" ]]; then
        if [[ "$2" == "up" ]]; then
            ${brightnessctl} set +5%

        elif [[ "$2" == "down" ]]; then
            ${brightnessctl} set 5%-
        fi
        TAG="backlight"
        LABEL="Backlight"
        VAL="$(${brightnessctl} -m | ${pkgs.gawk}/bin/awk -F, '{print substr($4, 0, length($4)-1)}')"
    fi

    ${pkgs.libnotify}/bin/notify-send \
          --hint=string:x-dunst-stack-tag:$TAG \
          --hint=string:synchronous:$TAG \
          --hint=int:value:$VAL \
          "$LABEL $VAL%"

  ''
