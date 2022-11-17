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

      color listnormal black default
      color listfocus white default
      color listnormal_unread white default
      color listfocus_unread magenta default bold
      color info white black bold
      color article white default bold
      user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
    '';
  };
}
