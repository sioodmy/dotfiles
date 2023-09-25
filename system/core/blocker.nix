{pkgs, ...}:
# this should block *most* junk sites
# make sure to ALWAYS lock commit hash to avoid fed honeypots
# three letter agencies go fuck yourself
{
  networking.extraHosts =
    builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/shreyasminocha/shady-hosts/fc9cc4020e80b3f87024c96178cba0f766b95e7a/hosts";
      sha256 = "jbsEiIcOjoglqLeptHhwWhvL/p0PI3DVMdGCzSXFgNA=";
      # blocks some shady fed sites
    })
    + builtins.readFile (pkgs.fetchurl {
      # blocks crypto phishing scams
      url = "https://raw.githubusercontent.com/MetaMask/eth-phishing-detect/3be0b9594f0bc6e3e699ee30cb2e809618539597/src/hosts.txt";
      sha256 = "b3HvaLxnUJZOANUL/p+XPNvu9Aod9YLHYYtCZT5Lan0=";
    });
}
