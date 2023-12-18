_: {
  programs.zathura = {
    enable = true;
    options = {
      font = "Iosevka 15";

      default-fg = "#CDD6F4";
      default-bg = "rgba(30, 30, 46, 0.8)";

      completion-bg = "#313244";
      completion-fg = "#CDD6F4";
      completion-highlight-bg = "#575268";
      completion-highlight-fg = "#CDD6F4";
      completion-group-bg = "#313244";
      completion-group-fg = "#89B4FA";

      statusbar-fg = "#CDD6F4";
      statusbar-bg = "#313244";
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;

      notification-bg = "#313244";
      notification-fg = "#CDD6F4";
      notification-error-bg = "#313244";
      notification-error-fg = "#F38BA8";
      notification-warning-bg = "#313244";
      notification-warning-fg = "#FAE3B0";
      selection-notification = true;

      inputbar-fg = "#CDD6F4";
      inputbar-bg = "rgba(30, 30, 46, 0.8)";

      recolor = true;
      recolor-lightcolor = "rgba(0,0,0,0)";
      recolor-darkcolor = "#CDD6F4";

      index-fg = "#CDD6F4";
      index-bg = "rgba(30, 30, 46, 0.8)";
      index-active-fg = "#CDD6F4";
      index-active-bg = "#313244";

      render-loading-bg = "rgba(30, 30, 46, 0.8)";
      render-loading-fg = "#CDD6F4";

      highlight-color = "#575268";
      highlight-active-color = "#F5C2E7";
      highlight-fg = "#F5C2E7";

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
