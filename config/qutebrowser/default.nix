{ pkgs, config, ... }:

{
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      g = "https://www.google.com/search?hl=en&q={}";
      y = "https://www.youtube.com/results?search_query={}";
    };

    settings = {
      hints.border = "1px solid #D9E0EE";
      fonts = {
        default_family = "JetBrains Mono";
        default_size = "12pt";
      };
      colors = {
        webpage.darkmode.enabled = true;
        completion = {
          category = {
            bg = "#1E1E2E";
            fg = "#D9E0EE";
            border.bottom = "#302D41";
            border.top = "#302D41";
          };
          even.bg = "#1E1E2E";
          odd.bg = "#1E1E2E";
          fg = "#D9E0EE";
          item.selected = {
            bg = "#302D41";
            fg = "#D9E0EE";
            border.bottom = "#ABE9B3";
            border.top = "#ABE9B3";
          };
          match.fg = "#F8BD96";
          scrollbar.bg = "#1E1E2E";
          scrollbar.fg = "#D9E0EE";
        };
        downloads = {
          bar.bg = "#1E1E2E";
          error.bg = "#1E1E2E";
          error.fg = "#F28FAD";
          stop.bg = "#1E1E2E";
          system.bg = "none";
        };
        hints = {
          bg = "#1E1E2E";
          fg = "#D9E0EE";
          match.fg = "#C3BAC6";
        };
        keyhint = {
          bg = "#1E1E2E";
          fg = "#ABE9B3";
          suffix.fg = "#F8BD96";
        };
        messages = {
          error.bg = "#1E1E2E";
          error.border = "#302D41";
          error.fg = "#F28FAD";
          info.bg = "#1E1E2E";
          info.fg = "#C3BAC6";
          warning.bg = "#1E1E2E";
          warning.border = "#302D41";
          warning.fg = "#F28FAD";
        };
        prompts = {
          border = "1px solid #302D41";
          fg = "#ABE9B3";
          selected.bg = "#96CDFB";
        };
        statusbar = {
          caret = {
            bg = "#1E1E2E";
            fg = "#D9E0EE";
            selection.bg = "#1E1E2E";
            selection.fg = "#ABE9B3";
          };
          command = {
            bg = "#1E1E2E";
            fg = "#ABE9B3";

          };
          insert = {
            fg = "#D9E0EE";
            bg = "#1E1E2E";
          };
          normal = {
            bg = "#1E1E2E";
            fg = "#D9E0EE";
          };
          passthrough = {
            bg = "#1E1E2E";
            fg = "#D9E0EE";
          };
          private = {
            bg = "#1E1E2E";
            fg = "#D9E0EE";
          };
          progress.bg = "#1E1E2E";
          url = {
            error.fg = "#F28FAD";
            fg = "#D9E0EE";
            hover.fg = "#ABE9B3";
            success.https.fg = "#ABE9B3";
            success.http.fg = "#ABE9B3";
            warn.fg = "#FAE3B0";
          };
        };
        tabs = {
          bar.bg = "#1E1E2E";
          even.bg = "#1E1E2E";
          even.fg = "#D9E0EE";
          indicator = {
            error = "#F28FAD";
            start = "#F8BD96";
            stop = "#ABE9B3";
            system = "none";
          };
          odd.fg = "#D9E0EE";
          odd.bg = "#1E1E2E";
          selected = {
            even.fg = "#D9E0EE";
            even.bg = "#1E1E2E";
            odd.fg = "#D9E0EE";
            odd.bg = "#1E1E2E";
          };
        };
      };
      tabs = {
        favicons.scale = 1.25;
        indicator.width = 1;
      };

    };

    keyBindings = {
      normal = {
        "<Ctrl-v>" = "spawn mpv {url}";
      };
      prompt = {
        "<Ctrl-y>" = "prompt-yes";
      };
    };

    extraConfig = ''
    config.set('tabs.padding', {"top": 5, "bottom": 5, "left": 5, "right": 5})
    config.set('statusbar.padding', {"top": 5, "bottom": 5, "left": 5, "right": 5})
      '';
  };
}
