{
  inputs,
  pkgs,
  cfg,
  ...
}: let
  config = with cfg.theme.colors;
    pkgs.writeText "foot.ini" ''
      [bell]
      command=notify-send bell
      command-focused=no
      notify=yes
      urgent=yes

      [colors]
      alpha=1.0
      background=${base00}
      bright0=${base03}
      bright1=${base08}
      bright2=${base0B}
      bright3=${base0A}
      bright4=${base0D}
      bright5=${base0E}
      bright6=${base0C}
      bright7=${base07}
      foreground=${base05}
      regular0=${base00}
      regular1=${base08}
      regular2=${base0B}
      regular3=${base0A}
      regular4=${base0D}
      regular5=${base0E}
      regular6=${base0C}
      regular7=${base05}

      [cursor]
      beam-thickness=2
      style=beam

      [key-bindings]
      show-urls-launch=Control+Shift+u
      unicode-input=Control+Shift+i

      [main]
      app-id=foot
      bold-text-in-bright=no
      dpi-aware=yes
      font=monospace:size=9
      locked-title=no
      notify=notify-send -a $/{app-id} -i $/{app-id} $/{title} $/{body}
      pad=12x21 center
      resize-delay-ms=100
      selection-target=primary
      shell=${cfg.nucleus}/bin/nucleus
      term=xterm-256color
      title=foot
      vertical-letter-offset=-0.75
      word-delimiters=,│`|:"'()[]{}<>

      [mouse]
      hide-when-typing=yes

      [mouse-bindings]
      primary-paste=BTN_MIDDLE
      select-begin=BTN_LEFT
      select-begin-block=Control+BTN_LEFT
      select-extend=BTN_RIGHT
      select-extend-character-wise=Control+BTN_RIGHT
      select-word=BTN_LEFT-2
      select-word-whitespace=Control+BTN_LEFT-2
      selection-override-modifiers=Shift

      [scrollback]
      lines=10000
      multiplier=3

      [url]
      label-letters=sadfjklewcmpgh
      launch=xdg-open $\{url}
      osc8-underline=url-mode
      protocols=http, https, ftp, ftps, file, gemini, gopher, irc, ircs
      uri-characters=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+="'()[]

    '';
in {
  basePackage = pkgs.foot;
  flags = ["--config=${config}"];
}
