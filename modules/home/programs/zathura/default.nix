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
        default-bg = "#1e1e2e";

        completion-bg = "#1e1e2e";
        completion-fg = "#d8dee9";
        completion-highlight-bg = "#1e1e2e";
        completion-highlight-fg = "#d8dee9";
        completion-group-bg = "#1e1e2e";
        completion-group-fg = "#5e81ac";

        statusbar-fg = "#d8dee9";
        statusbar-bg = "#1e1e2e";
        statusbar-h-padding = 10;
        statusbar-v-padding = 10;

        notification-bg = "#1e1e2e";
        notification-fg = "#d8dee9";
        notification-error-bg = "#1e1e2e";
        notification-error-fg = "#bf616a";
        notification-warning-bg = "#1e1e2e";
        notification-warning-fg = "#f9e2af";
        selection-notification = true;

        inputbar-fg = "#d8dee9";
        inputbar-bg = "#1e1e2e";

        recolor = true;
        recolor-lightcolor = "#1e1e2e";
        recolor-darkcolor = "#d8dee9";

        index-fg = "#d8dee9";
        index-bg = "#1e1e2e";
        index-active-fg = "#d8dee9";
        index-active-bg = "#1e1e2e";

        render-loading-bg = "#1e1e2e";
        render-loading-fg = "#d8dee9";

        highlight-color = "#5b6078";
        highlight-active-color = "#f0c6c6";
        highlight-fg = "#f4dbd6";

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
