{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.programs.zathura;
in {
  options.modules.programs.zathura = { enable = mkEnableOption "zathura"; };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      options = {
        font = "monospace 13";

        default-fg = "#d8dee9";
        default-bg = "#2e3440";

        completion-bg = "#2e3440";
        completion-fg = "#d8dee9";
        completion-highlight-bg = "#434c5e";
        completion-highlight-fg = "#d8dee9";
        completion-group-bg = "#2e3440";
        completion-group-fg = "#d8dee9";

        statusbar-fg = "#d8dee9";
        statusbar-bg = "#2e3440";
        statusbar-h-padding = 10;
        statusbar-v-padding = 10;

        notification-bg = "#3b4252";
        notification-fg = "#eceff4";
        notification-error-bg = "#bf616a";
        notification-error-fg = "#eceff4";
        notification-warning-bg = "#ebcb8b";
        notification-warning-fg = "#2e3440";
        selection-notification = true;

        inputbar-fg = "#a3be8c";
        inputbar-bg = "#2e3440";

        recolor = true;
        recolor-lightcolor = "#2e3440";
        recolor-darkcolor = "#d8dee9";

        index-fg = "#d8dee9";
        index-bg = "#2e3440";
        index-active-fg = "#d8dee9";
        index-active-bg = "#434c5e";

        render-loading-bg = "#2e3440";
        render-loading-fg = "#d8dee9";

        highlight-color = "#5e81ac";
        highlight-active-color = "#88c0d0";
        highlight-fg = "#d8dee9";

        selection-clipboard = "clipboard";
        adjust-open = "best-fit";
        pages-per-row = "1";
        scroll-page-aware = "true";
        scroll-full-overlap = "0.01";
        scroll-step = "50";
        zoom-min = "10";
        guioptions = "none";

      };
    };
  };
}
