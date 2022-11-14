# Schizofox

<img align="left" src="https://search.unlocked.link/image_proxy?url=https%3A%2F%2Fi.kym-cdn.com%2Fentries%2Ficons%2Ffacebook%2F000%2F037%2F493%2Fcovergn.jpg&h=80248b2686fc2e1618aae35fb3764bb260515e7675203963f631493f4cd14508" width="400" alt="glowie" />
Privacy oriented Firefox ESR configuration.

```nix
# Example configration
programs.schizofox = {
  enable = true;
  userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
  netflixCuckFix = true;
  translate = {
    enable = true;
    sourceLang = "en";
    targetLang = "pl";
   };
};
```
