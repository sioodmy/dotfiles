{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.desktop.lockscreen;
  sleep-noti = pkgs.writeScript "sleep-noti" ''
    #! ${pkgs.bash}/bin/bash
    ${pkgs.libnotify}/bin/notify-send 'Sleeping in 60 seconds..'
  '';
  lockscreen = (
    pkgs.writeScriptBin "lockscreen" ''
      #! ${pkgs.zsh}/bin/zsh
      background=#2e3440
      insidecolor=#2e3440ff
      insidevercolor=#2e3440ff
      insidewrongcolor=#bf616aff
      ringcolor=#5e81ac1A
      ringvercolor=#81A1C1ff
      ringwrongcolor=#bf616aff
      keyhlcolor=#A3BE8Cff
      bshlcolor=#bf616aff
      layoutcolor=#5e81acff
      seperatorcolor=#3b425200
      timecolor=#d8dee97f
      datecolor=#d8dee9ff
      verifcolor=#d8dee9ff
      wrongcolor=#d8dee9ff
      ${pkgs.i3lock-color}/bin/i3lock-color \
        -n \
        --indicator \
        -c $background \
        -S=0 \
        --inside-color=$insidecolor \
        --insidever-color=$insidevercolor \
        --insidewrong-color=$insidewrongcolor \
        \
        --ring-color=$ringcolor \
        --ringver-color=$ringvercolor \
        --ringwrong-color=$ringwrongcolor \
        \
        --line-uses-inside \
        --keyhl-color=$keyhlcolor \
        --bshl-color=$bshlcolor \
        \
        --layout-color=$layoutcolor \
        --separator-color=$seperatorcolor \
        --radius=160 \
        --ring-width=24 \
        --noinput-text="Enter Password" \
        \
        --clock \
        \
        --time-color=$timecolor \
        --time-str="%H:%M:%S" \
        --time-pos="x+w/2:y+h/1.8" \
        --time-font="monospace" \
        --time-size=22 \
        \
        --date-color=$datecolor \
        --date-str="%A" \
        --date-pos="x+w/2:y+h/1.95" \
        --date-font="monospace" \
        --date-size=57 \
        \
        --verif-text="" \
        --verif-color=$verifcolor \
        --verif-font="monospace" \
        --verif-pos="x+w/2:y+h/2" \
        --verif-size=30 \
        \
        --wrong-text="" \
        --wrong-color=$wrongcolor \
        --wrong-font="monospace" \
        --wrong-pos="x+w/2:y+h/2" \
        --wrong-size=30 &&\
    '');
in {

  options.modules.desktop.lockscreen = {
    enable = mkEnableOption "lockscreen";
    autolock = mkOption {
      type = types.bool;
      default = true;
      description = "Enable XAutolock";
    };
    time = mkOption {
      type = types.ints.unsigned;
      default = 10;
      description = "Autolock timer";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.i3lock-color lockscreen ];

    services.sxhkd.keybindings = mkIf config.modules.services.sxhkd.enable {
      "super + shift + p" = "${lockscreen}/bin/lockscreen";
    };

  };

}
