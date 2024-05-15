{theme, ...}: {
  programs.zathura = {
    enable = true;
    options = with theme.colors; {
      font = "Iosevka 15";

      default-fg = "#${text}";
      default-bg = "#${base}";

      completion-bg = "#${surface0}";
      completion-fg = "#${text}";
      completion-highlight-bg = "#575268";
      completion-highlight-fg = "#${text}";
      completion-group-bg = "#${surface0}";
      completion-group-fg = "#${text}";

      statusbar-bg = "#${base}";
      statusbar-fg = "#${text}";
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;

      notification-bg = "#${surface0}";
      notification-fg = "#${text}";
      notification-error-bg = "#${surface0}";
      notification-error-fg = "#${red}";
      notification-warning-bg = "#${base}";
      notification-warning-fg = "#${yellow}";
      selection-notification = true;

      inputbar-fg = "#${text}";
      inputbar-bg = "#${base}";

      recolor = true;
      recolor-lightcolor = "rgba(0,0,0,0)";
      recolor-darkcolor = "#${text}";

      index-fg = "#${text}";
      index-bg = "#${base}";
      index-active-fg = "#${text}";
      index-active-bg = "#${surface0}";

      render-loading-bg = "#${base}";
      render-loading-fg = "#${text}";

      highlight-color = "#${mauve}";
      highlight-active-color = "#${accent}";
      highlight-fg = "#${text}";

      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
      pages-per-row = "1";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      smooth-scroll = true;
      zoom-min = "10";
      guioptions = "none";
    };
  };
}
