{ pkgs, config, theme, ... }:

{
  home.packages = [ pkgs.tdrop ];
  programs.alacritty = {
    enable = true;
    settings = with theme.colors; {
      key_bindings = [
        {
          key = "C";
          mods = "Control|Alt";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control|Alt";
          action = "Paste";
        }
        {
          key = "Equals";
          mods = "Command";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Command";
          action = "DecreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Command|Shift";
          action = "ResetFontSize";
        }
      ];

      dynamic_padding = true;

      window = {
        dimensions = {
          columns = 100;
          lines = 25;
        };
        padding = {
          x = 16;
          y = 16;
        };
      };
      scrolling = {
        history = 38;
        multiplier = 3;
      };
      font = {
        size = 12;
        normal = {
          family = "monospace";
          style = "Medium";
        };
        bold = {
          family = "monospace";
          style = "Bold";
        };
        italic = {
          family = "monospace";
          style = "Light italic";
        };
        use_thin_strokes = true;
      };

      mouse.hide_when_typing = true;

      colors = {
        primary = {
          background = "0x${bg}";
          foreground = "0x${fg}";
        };
        cursor = {
          text = "0x${bg}";
          cursor = "0x${c6}";
        };

        normal = {
          black = "0x${c0}";
          red = "0x${c1}";
          green = "0x${c2}";
          yellow = "0x${c3}";
          blue = "0x${c4}";
          magenta = "0x${c6}";
          cyan = "0x${c5}";
          white = "0x${fg}";
        };

        bright = {
          black = "0x${c8}";
          red = "0x${c9}";
          green = "0x${c10}";
          yellow = "0x${c11}";
          blue = "0x${c12}";
          magenta = "0x${c14}";
          cyan = "0x${c13}";
          white = "0x${fg}";
        };

      };
    };
  };
}
