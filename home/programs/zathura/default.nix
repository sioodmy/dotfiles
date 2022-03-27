{ pkgs, config, theme, ... }:

{
  programs.zathura = {
    enable = true;
    options = with theme.colors; {
      font = "monospace 13";

      default-fg = "#${fg}";
      default-bg = "#${bg}";

      completion-bg = "#${bg}";
      completion-fg = "#${fg}";
      completion-highlight-bg = "#${bg}";
      completion-highlight-fg = "#${fg}";
      completion-group-bg = "#${bg}";
      completion-group-fg = "#${ac}";

      statusbar-fg = "#${fg}";
      statusbar-bg = "#${bg}";
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;

      notification-bg = "#${bg}";
      notification-fg = "#${fg}";
      notification-error-bg = "#${bg}";
      notification-error-fg = "#${c1}";
      notification-warning-bg = "#${bg}";
      notification-warning-fg = "#${c11}";
      selection-notification = true;

      inputbar-fg = "#${fg}";
      inputbar-bg = "#${bg}";

      recolor = true;
      recolor-lightcolor = "#${bg}";
      recolor-darkcolor = "#${fg}";

      index-fg = "#${fg}";
      index-bg = "#${bg}";
      index-active-fg = "#${fg}";
      index-active-bg = "#${bg}";

      render-loading-bg = "#${bg}";
      render-loading-fg = "#${fg}";

      highlight-color = "#${c8}";
      highlight-active-color = "#${c6}";
      highlight-fg = "#${c6}";

      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
      pages-per-row = "1";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "50";
      zoom-min = "10";

    };
  };
}
