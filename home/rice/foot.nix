{pkgs, ...}: {
  home.packages = with pkgs; [
    libsixel
    # for displaying images
  ];
  programs.foot = {
    enable = true;
    # doesnt work properly
    server.enable = true;
    settings = {
      main = {
        app-id = "foot";
        title = "foot";
        locked-title = "no";
        term = "xterm-256color";
        font = "monospace:size=10.5";
        vertical-letter-offset = "-0.75";
        pad = "12x21 center";
        resize-delay-ms = 100;
        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        selection-target = "primary";
        # box-drawings-uses-font-glyphs = "yes";
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
      colors = {
        alpha = "0.6";
        foreground = "cdd6f4";
        background = "1e1e2e";

        regular0 = "45475a";
        regular1 = "f38ba8";
        regular2 = "a6e3a1";
        regular3 = "f9e2af";
        regular4 = "89b4fa";
        regular5 = "f5c2e7";
        regular6 = "94e2d5";
        regular7 = "bac2de";

        bright0 = "585b70";
        bright1 = "f38ba8";
        bright2 = "a6e3a1";
        bright3 = "f9e2af";
        bright4 = "89b4fa";
        bright5 = "f5c2e7";
        bright6 = "94e2d5";
        bright7 = "a6adc8";
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
        #select-row = "BTN_LEFT-3";
      };
    };
  };
}
