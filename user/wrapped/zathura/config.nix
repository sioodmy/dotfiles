{
  lib,
}: let
  inherit (lib) isBool concatStringsSep mapAttrsToList;

  options = {
    recolor = true;
    adjust-open = "best-fit";
    pages-per-row = 1;
    scroll-page-aware = true;
    smooth-scroll = true;
    selection-clipboard = "clipboard";
    guioptions = "";
    zoom-min = 10;
    render-loading = true;
    scroll-full-overlap = "0.01";
    scroll-step = 100;

    notification-error-bg = "#2E3440";
    notification-error-fg = "#BF616A";
    notification-warning-bg = "#2E3440";
    notification-warning-fg = "#D08770";
    notification-bg = "#2E3440";
    notification-fg = "#D8DEE9";

    completion-bg = "#2E3440";
    completion-fg = "#D8DEE9";
    completion-group-bg = "#3B4252";
    completion-group-fg = "#D8DEE9";
    completion-highlight-bg = "#88C0D0";
    completion-highlight-fg = "#3B4252";

    index-bg = "#2E3440";
    index-fg = "#8FBCBB";
    index-active-bg = "#8FBCBB";
    index-active-fg = "#2E3440";

    inputbar-bg = "#2E3440";
    inputbar-fg = "#E5E9F0";

    statusbar-bg = "#2E3440";
    statusbar-fg = "#E5E9F0";

    highlight-color = "#D08770";
    highlight-active-color = "#BF616A";

    default-bg = "#2E3440";
    default-fg = "#D8DEE9";
    render-loading-bg = "#2E3440";
    render-loading-fg = "#434C5E";

    recolor-lightcolor = "#2E3440";
    recolor-darkcolor = "#ECEFF4";
  };

  formatLine = n: v: let
    formatValue = v:
      if isBool v
      then
        (
          if v
          then "true"
          else "false"
        )
      else toString v;
  in ''set ${n}	"${formatValue v}"'';
in
  concatStringsSep "\n" (mapAttrsToList formatLine options) + "\n"
