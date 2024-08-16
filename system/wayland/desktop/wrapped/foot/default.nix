{
  pkgs,
  colors,
  ...
}: let
  inherit (pkgs.lib.meta) getExe getExe';

  notify-send = getExe pkgs.libnotify;
  xdg-open = getExe' pkgs.xdg-utils "xdg-open";

  config = pkgs.writeText "foot.ini" (pkgs.lib.generators.toINI {} {
    main = {
      term = "foot";
      app-id = "foot";
      title = "foot";
      locked-title = "no";

      font = "monospace:size=16";
      line-height = 20;
      letter-spacing = 0;
      horizontal-letter-offset = 0;
      vertical-letter-offset = -0.75;
      box-drawings-uses-font-glyphs = "no";
      dpi-aware = "no";

      initial-window-size-chars = "104x36";
      initial-window-mode = "windowed";
      pad = "8x8 center";
      resize-delay-ms = 100;

      bold-text-in-bright = "no";
      word-delimiters = ",│`|:\"'()[]{}<>";
      selection-target = "primary";
    };
    bell = {
      urgent = "yes";
      notify = "yes";
      command = "${notify-send} bell";
      command-focused = "no";
    };
    scrollback = {
      lines = 100000;
      multiplier = 10.0;
      indicator-position = "relative";
      indicator-format = "line";
    };
    url = {
      launch = "${xdg-open} \${url}";
      label-letters = "sadfjklewcmpgh";
      osc8-underline = "always";
      protocols = "http, https, ftp, ftps, file, gemini, gopher, irc, ircs";
      uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
    };
    cursor = {
      style = "beam";
      blink = "no";
    };
    mouse = {
      hide-when-typing = "yes";
      alternate-scroll-mode = "yes";
    };
    csd = {
      preferred = "server";
    };
    key-bindings = {
      scrollback-up-half-page = "Control+k";
      scrollback-up-page = "Control+Shift+k";
      scrollback-down-half-page = "Control+j";
      scrollback-down-page = "Control+Shift+j";
    };
    mouse-bindings = {
      selection-override-modifiers = "Shift";
      primary-paste = "BTN_MIDDLE";
      select-begin = "BTN_LEFT";
      select-begin-block = "Control+BTN_LEFT";
      select-extend = "BTN_RIGHT";
      select-extend-character-wise = "Control+BTN_RIGHT";
      select-word = "BTN_LEFT-2";
      select-word-whitespace = "Control+BTN_LEFT-2";
    };
    desktop-notifications = {
      command = "${notify-send} -a \${app-id} -i \${app-id} \${title} \${body}";
    };
    colors = with colors; {
      alpha = 1.0;
      background = "${base00}";
      bright0 = "${base03}";
      bright1 = "${base08}";
      bright2 = "${base0B}";
      bright3 = "${base0A}";
      bright4 = "${base0D}";
      bright5 = "${base0E}";
      bright6 = "${base0C}";
      bright7 = "${base07}";
      foreground = "${base05}";
      regular0 = "${base00}";
      regular1 = "${base08}";
      regular2 = "${base0B}";
      regular3 = "${base0A}";
      regular4 = "${base0D}";
      regular5 = "${base0E}";
      regular6 = "${base0C}";
      regular7 = "${base05}";
    };
  });
in {
  basePackage = pkgs.foot;
  flags = ["--config=${config}"];
}
