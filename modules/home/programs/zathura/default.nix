{ pkgs, lib, config, theme, ... }:
with lib;
let cfg = config.modules.programs.zathura;
in {
  options.modules.programs.zathura = { enable = mkEnableOption "zathura"; };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      options = with theme.colors; {
        font = "monospace 13";

        default-fg = "#d8dee9";
        default-bg = "#2E3440";

        completion-bg = "#2E3440";
        completion-fg = "#d8dee9";
        completion-highlight-bg = "#2E3440";
        completion-highlight-fg = "#d8dee9";
        completion-group-bg = "#2E3440";
        completion-group-fg = "#5e81ac";

        statusbar-fg = "#d8dee9";
        statusbar-bg = "#2E3440";
        statusbar-h-padding = 10;
        statusbar-v-padding = 10;

        notification-bg = "#2E3440";
        notification-fg = "#d8dee9";
        notification-error-bg = "#2E3440";
        notification-error-fg = "#bf616a";
        notification-warning-bg = "#2E3440";
        notification-warning-fg = "#EBCB8B";
        selection-notification = true;

        inputbar-fg = "#d8dee9";
        inputbar-bg = "#2E3440";

        recolor = true;
        recolor-lightcolor = "#2E3440";
        recolor-darkcolor = "#d8dee9";

        index-fg = "#d8dee9";
        index-bg = "#2E3440";
        index-active-fg = "#d8dee9";
        index-active-bg = "#2E3440";

        render-loading-bg = "#2E3440";
        render-loading-fg = "#d8dee9";

        highlight-color = "#4C566A";
        highlight-active-color = "#88C0D0";
        highlight-fg = "#88C0D0";

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
