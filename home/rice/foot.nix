{
  pkgs,
  theme,
  inputs,
  ...
}: let
  nucleus = inputs.andromeda.packages.${pkgs.system}.nucleus;
in {
  home.packages = [
    pkgs.libsixel
    nucleus
  ];
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        app-id = "foot";
        title = "foot";
        locked-title = "no";
        term = "xterm-256color";
        font = "monospace:size=9";
        shell = "${nucleus}/bin/nucleus";
        vertical-letter-offset = "-0.75";
        pad = "12x21 center";
        resize-delay-ms = 100;
        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        selection-target = "primary";
        dpi-aware = "yes";
        bold-text-in-bright = "no";
        word-delimiters = ",│`|:\"'()[]{}<>";
      };
      cursor = {
        style = "beam";
        beam-thickness = 2;
      };
      scrollback = {
        lines = 10000;
        multiplier = 3;
      };

      bell = {
        urgent = "yes";
        notify = "yes";
        command = "notify-send bell";
        command-focused = "no";
      };
      url = {
        launch = "xdg-open \${url}";
        label-letters = "sadfjklewcmpgh";
        osc8-underline = "url-mode";
        protocols = "http, https, ftp, ftps, file, gemini, gopher, irc, ircs";

        uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
      };
      colors = with theme.colors; {
        alpha = "1.0";
        foreground = text;
        background = base;

        regular0 = surface1;
        regular1 = red;
        regular2 = green;
        regular3 = yellow;
        regular4 = blue;
        regular5 = pink;
        regular6 = teal;
        regular7 = subtext1;

        bright0 = surface2;
        bright1 = red;
        bright2 = green;
        bright3 = yellow;
        bright4 = blue;
        bright5 = pink;
        bright6 = teal;
        bright7 = subtext0;
      };
      mouse = {
        hide-when-typing = "yes";
      };
      key-bindings = {
        show-urls-launch = "Control+Shift+u";
        unicode-input = "Control+Shift+i";
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
    };
  };
}
