{ pkgs, config, theme, ... }: {
  programs.kitty = {
    enable = true;
    settings = with theme.colors; {

      font_family = "monospace";
      font_size = 15;

      window_padding_width = 26;

      foreground = "#${fg}";
      background = "#${bg}";

      selection_foreground = "#${fg}";
      selection_background = "#${ac}";

      cursor = "#${c6}";
      cursor_text_color = "#${bg}";
      url_color = "#${c6}";

      mark1_foreground = "#${bg}";
      mark1_background = "#${c4}";
      mark2_foreground = "#${bg}";
      mark2_background = "#${c6}";
      mark3_foreground = "#${bg}";
      mark3_background = "#${c2}";

      color0 = "#${c0}";
      color1 = "#${c1}";
      color2 = "#${c2}";
      color3 = "#${c3}";
      color4 = "#${c4}";
      color5 = "#${c5}";
      color6 = "#${c6}";
      color7 = "#${c7}";
      color8 = "#${c8}";
      color9 = "#${c9}";
      color10 = "#${c10}";
      color11 = "#${c11}";
      color12 = "#${c12}";
      color13 = "#${c13}";
      color14 = "#${c14}";
      color15 = "#${c15}";

    };
  };
}
