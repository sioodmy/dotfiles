{
  pkgs,
  ...
}:
let
  inherit (pkgs.lib.meta) getExe getExe';

  notify-send = getExe pkgs.libnotify;
  xdg-open = getExe' pkgs.xdg-utils "xdg-open";

  config = pkgs.writeText "foot.ini" (
    pkgs.lib.generators.toINI { } {
      main = {
        term = "foot";
        app-id = "foot";
        title = "foot";
        locked-title = "no";

        font = "monospace:size=10.5";
        line-height = 20;
        letter-spacing = 0;
        horizontal-letter-offset = 0;
        vertical-letter-offset = 0;
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
        preferred = "none";
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
      colors-dark = {
        alpha = 0.91;
        background = "24273a";
        foreground = "cad3f5";
        bright0 = "5b6078";
        bright1 = "ed8796";
        bright2 = "a6da95";
        bright3 = "eed49f";
        bright4 = "8aadf4";
        bright5 = "f5bde6";
        bright6 = "8bd5ca";
        bright7 = "a5adcb";
        regular0 = "494d64";
        regular1 = "ed8796";
        regular2 = "a6da95";
        regular3 = "eed49f";
        regular4 = "8aadf4";
        regular5 = "f5bde6";
        regular6 = "8bd5ca";
        regular7 = "b8c0e0";
        cursor = "181926 f4dbd6";
        "16" = "f5a97f";
        "17" = "f4dbd6";
      };
    }
  );
in
pkgs.symlinkJoin {
  name = "foot-wrapped";
  paths = [ pkgs.foot ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/foot --add-flags "--config=${config}"
  '';
}
