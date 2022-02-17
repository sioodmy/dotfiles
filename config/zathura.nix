{ pkgs, config, ...}:

{
    programs.zathura = {
        enable = true;
        options = {
            font = "JetBrains Mono 13";

            default-fg = "#d9e0ee";
            default-bg = "#1e1d2f";

            completion-bg = "#302d41";
            completion-fg = "#d9e0ee";
            completion-highlight-bg = "#575268";
            completion-highlight-fg = "#d9e0ee"; 
            completion-group-bg = "#302d41";
            completion-group-fg = "#96cdfb";

            statusbar-fg = "#d9e0ee";
            statusbar-bg = "#302d41";
            statusbar-h-padding = 10;
            statusbar-v-padding = 10;

            notification-bg = "#302d41";
            notification-fg = "#d9e0ee";
            notification-error-bg = "#302d41";
            notification-error-fg = "#f28fad";
            notification-warning-bg = "#302d41";
            notification-warning-fg = "#fae3b0";
            selection-notification = true;

            inputbar-fg = "#d9e0ee";
            inputbar-bg = "#302d41";

            recolor = true;
            recolor-lightcolor = "#1e1d2f"; 
            recolor-darkcolor = "#d9e0ee";

            index-fg = "#d9e0ee";
            index-bg = "#1e1d2f";
            index-active-fg = "#d9e0ee";
            index-active-bg = "#302d41";

            render-loading-bg = "#1e1d2f";
            render-loading-fg = "#d9e0ee";

            highlight-color = "#575268";
            highlight-active-color = "#f5c2e7";
            highlight-fg = "#f5c2e7";

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
