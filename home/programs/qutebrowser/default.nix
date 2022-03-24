{ pkgs, config, theme, ... }:

{
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      g = "https://www.google.com/search?hl=en&q={}";
      y = "https://www.youtube.com/results?search_query={}";
    };

    settings = with theme.colors; {
      hints.border = "1px solid #${fg}";
      fonts = {
        default_family = "${font}";
        default_size = "12pt";
      };
      colors = {
        webpage.darkmode.enabled = true;
        completion = {
          category = {
            bg = "#${bg}";
            fg = "#${fg}";
            border.bottom = "#${bg}";
            border.top = "#${bg}";
          };
          even.bg = "#${bg}";
          odd.bg = "#${bg}";
          fg = "#${fg}";
          item.selected = {
            bg = "#${c0}";
            fg = "#${fg}";
            border.bottom = "#${ac}";
            border.top = "#${ac}";
          };
          match.fg = "#${c11}";
          scrollbar.bg = "#${bg}";
          scrollbar.fg = "#${fg}";
        };
        downloads = {
          bar.bg = "#${bg}";
          error.bg = "#${bg}";
          error.fg = "#${c1}";
          stop.bg = "#${bg}";
          system.bg = "none";
        };
        hints = {
          bg = "#${bg}";
          fg = "#${fg}";
          match.fg = "#${c0}";
        };
        keyhint = {
          bg = "#${bg}";
          fg = "#${ac}";
          suffix.fg = "#${c11}";
        };
        messages = {
          error.bg = "#${bg}";
          error.border = "#${c7}";
          error.fg = "#${c1}";
          info.bg = "#${bg}";
          info.fg = "#${c7}";
          warning.bg = "#${bg}";
          warning.border = "#${c7}";
          warning.fg = "#${c1}";
        };
        prompts = {
          border = "1px solid #${c7}";
          fg = "#${ac}";
          selected.bg = "#${ac}";
        };
        statusbar = {
          caret = {
            bg = "#${bg}";
            fg = "#${fg}";
            selection.bg = "#${bg}";
            selection.fg = "#${ac}";
          };
          command = {
            bg = "#${bg}";
            fg = "#${ac}";

          };
          insert = {
            fg = "#${fg}";
            bg = "#${bg}";
          };
          normal = {
            bg = "#${bg}";
            fg = "#${fg}";
          };
          passthrough = {
            bg = "#${bg}";
            fg = "#${fg}";
          };
          private = {
            bg = "#${bg}";
            fg = "#${fg}";
          };
          progress.bg = "#${bg}";
          url = {
            error.fg = "#${c1}";
            fg = "#${fg}";
            hover.fg = "#${ac}";
            success.https.fg = "#${ac}";
            success.http.fg = "#${ac}";
            warn.fg = "#${c1}";
          };
        };
        tabs = {
          bar.bg = "#${bg}";
          even.bg = "#${bg}";
          even.fg = "#${fg}";
          indicator = {
            error = "#${c1}";
            start = "#${c11}";
            stop = "#${ac}";
            system = "none";
          };
          odd.fg = "#${fg}";
          odd.bg = "#${bg}";
          selected = {
            even.fg = "#${fg}";
            even.bg = "#${bg}";
            odd.fg = "#${fg}";
            odd.bg = "#${bg}";
          };
        };
      };
      tabs = {
        favicons.scale = 1.25;
        indicator.width = 1;
      };

    };

    keyBindings = {
      normal = { "<Ctrl-v>" = "spawn mpv {url}"; };
      prompt = { "<Ctrl-y>" = "prompt-yes"; };
    };

    extraConfig = ''
      config.set('tabs.padding', {"top": 5, "bottom": 5, "left": 5, "right": 5})
      config.set('statusbar.padding', {"top": 5, "bottom": 5, "left": 5, "right": 5})
      c.content.blocking.adblock.lists = ['https://easylist.to/easylist/easylist.txt', 'https://easylist.to/easylist/easyprivacy.txt', 'https://easylist-downloads.adblockplus.org/easylistdutch.txt', 'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt', 'https://www.i-dont-care-about-cookies.eu/abp/', 'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt']
        '';
  };
}
