{
  config,
  pkgs,
  ...
}:
# this should block *most* junk sites
# make sure to ALWAYS lock commit hash
{
  networking.extraHosts =
    builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/StevenBlack/hosts/e1bb5f08e6f9f4daef93cc327580a95f83959f38/alternates/fakenews-gambling-porn/hosts";
      sha256 = "tqw5FwFkyTVRiKCbJM/GwDHfpg7gUYOSppS4RB80Y9Y=";
      # blocks fakenews, gambling and coomer sites
    })
    + builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/shreyasminocha/shady-hosts/fc9cc4020e80b3f87024c96178cba0f766b95e7a/hosts";
      sha256 = "jbsEiIcOjoglqLeptHhwWhvL/p0PI3DVMdGCzSXFgNA=";
      # blocks some shady fed sites
    })
    + builtins.readFile (pkgs.fetchurl {
      # blocks crypto phishing scams
      url = "https://raw.githubusercontent.com/MetaMask/eth-phishing-detect/3be0b9594f0bc6e3e699ee30cb2e809618539597/src/hosts.txt";
      sha256 = "b3HvaLxnUJZOANUL/p+XPNvu9Aod9YLHYYtCZT5Lan0=";
    })
    + builtins.readFile (pkgs.fetchurl {
      # generic ads
      url = "https://raw.githubusercontent.com/AdAway/adaway.github.io/04f783e1d9f48bd9ac156610791d7f55d0f7d943/hosts.txt";
      sha256 = "mp0ka7T0H53rJ3f7yAep3ExXmY6ftpHpAcwWrRWzWYI=";
    });
}
