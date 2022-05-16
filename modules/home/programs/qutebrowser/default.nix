{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.programs.qutebrowser;
in {
  options.modules.programs.qutebrowser = {
    enable = mkEnableOption "qutebrowser";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.python39Packages.adblock ];

    programs.qutebrowser = {
      enable = true;
      searchEngines = {
        w =
          "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
        aw = "https://wiki.archlinux.org/?search={}";
        g = "https://www.google.com/search?hl=en&q={}";
        y = "https://www.youtube.com/results?search_query={}";
      };

      settings = {
        content = {
          blocking.method = "both";
          headers = {
            user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0";
            accept_language = "en-US,en;q=0.5";
          };
        };
        fonts = {
          default_family = "monospace";
          default_size = "12pt";
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
        prompt = { "<Ctrl-y>" = "prompt-yes"; };
      };

      extraConfig = ''
        config.set('tabs.padding', {"top": 5, "bottom": 5, "left": 5, "right": 5})
        config.set('statusbar.padding', {"top": 5, "bottom": 5, "left": 5, "right": 5})
        c.content.blocking.adblock.lists = [ \
        "https://easylist.to/easylist/easylist.txt", \
        "https://easylist.to/easylist/easyprivacy.txt", \
        "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt", \
        "https://easylist.to/easylist/fanboy-annoyance.txt", \
        "https://secure.fanboy.co.nz/fanboy-annoyance.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt", \
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2022.txt", \
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2021.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt", \
        "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt", \
        "https://pgl.yoyo.org/adservers/serverlist.php?showintro=0;hostformat=hosts", \
        "https://raw.githubusercontent.com/brave/adblock-lists/master/coin-miners.txt", \
        "https://raw.githubusercontent.com/brave/adblock-lists/master/brave-unbreak.txt", \
        "https://raw.githubusercontent.com/brave/adblock-lists/master/brave-lists/brave-social.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt", \
        "https://www.i-dont-care-about-cookies.eu/abp/", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt", \
        "https://raw.githubusercontent.com/MajkiIT/polish-ads-filter/master/polish-adblock-filters/adblock.txt", \
        "https://raw.githubusercontent.com/MajkiIT/polish-ads-filter/master/adblock_social_filters/adblock_social_list.txt", \
        "https://raw.githubusercontent.com/MajkiIT/polish-ads-filter/master/cookies_filters/adblock_cookies.txt", \
        "https://raw.githubusercontent.com/FiltersHeroes/PolishAnnoyanceFilters/master/PPB.txt", \
        "https://raw.githubusercontent.com/FiltersHeroes/PolishAntiAnnoyingSpecialSupplement/master/polish_rss_filters.txt", \
        "https://raw.githubusercontent.com/FiltersHeroes/KAD/master/KAD.txt", \
        "https://alleblock.pl/alleblock/alleblock.txt", \
        "https://raw.githubusercontent.com/olegwukr/polish-privacy-filters/master/anti-adblock.txt",
        ]
          '';
    };
  };
}
