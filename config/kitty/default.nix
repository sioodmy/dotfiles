{ pkgs, config, theme, ...}:
{
  programs.kitty = {
    enable = true;
    settings = with theme.colors; {
      foreground = "${fg}";
      background = "${bg}";
      selection_foreground = "${fg}";
      selection_background = "${ac}";
      cursor = "${c6}";
      cursor_text_color = "${bg}";
      url_color = "${c6}";
      mark1_foreground = "${bg}";
      mark1_background = "${c4}";
      mark2_foreground = "${bg}";
      mark2_background = "${c6}";
      mark3_foreground = "${bg}";
      mark3_background = "${c2}";

    };
  };
}
