{
  config,
  pkgs,
  ...
}: {
  programs.newsboat = {
    enable = true;
    autoReload = true;
    urls = [
      # https://hackaday.com/blog/feed/
      {
        title = "Wiadomosci blisko ciebie";
        tags = ["news" "twitter"];
        url = "https://nitter.net/WBC24News/rss";
      }
      {
        title = "LukaszBok";
        tags = ["news" "twitter"];
        url = "https://nitter.net/LukaszBok/rss";
      }
      {
        title = "KIKS";
        tags = ["news" "twitter"];
        url = "https://weekly.nixos.org/feeds/all.rss.xml";
      }
    ];
    extraConfig = ''
      download-full-page yes
      download-retries 3
      error-log /dev/null
      max-items 0
      bind-key j down
      bind-key k up
      bind-key j next articlelist
      bind-key k prev articlelist
      bind-key J next-feed articlelist
      bind-key K prev-feed articlelist
      bind-key G end
      bind-key g home
      bind-key d pagedown
      bind-key u pageup
      bind-key l open
      bind-key h quit
      bind-key a toggle-article-read
      bind-key n next-unread
      bind-key N prev-unread
      bind-key D pb-download
      bind-key U show-urls
      bind-key x pb-delete

      color listnormal         color15 default
      color listnormal_unread  color2  default
      color listfocus_unread   color2  color0
      color listfocus          default color0
      color background         default default
      color article            default default
      color end-of-text-marker color8  default
      color info               color4  color8
      color hint-separator     default color8
      color hint-description   default color8
      color title              color14 color8

      highlight article "^(Feed|Title|Author|Link|Date): .+" color4 default bold
      highlight article "^(Feed|Title|Author|Link|Date):" color14 default bold

      highlight article "\\((link|image|video)\\)" color8 default
      highlight article "https?://[^ ]+" color4 default
      highlight article "\[[0-9]+\]" color6 default bold
      user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
    '';
  };
}
