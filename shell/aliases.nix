{pkgs, ...}: let
  inherit (pkgs.lib) getExe;
in rec {
  l = "${getExe pkgs.eza} --icons";
  e = "${getExe pkgs.eza} --icons -lha --git";

  ls = l;
  la = e;

  m = "mkdir";

  g = "git";
  n = "nix";
  v = "nvim";

  ytmp3 = "yt-dlp -x --embed-metadata --audio-quality 0 --audio-format mp3";

  cat = "${getExe pkgs.bat}";
  fzf = "${getExe pkgs.skim}";

  kys = "shutdown now";

  gpl = "curl https://www.gnu.org/licenses/gpl-3.0.txt -o LICENSE";

  gcb = "git checkout";
  gd = "git pull";
  gu = "git push";
  gc = "git commit";
  ga = "git add";
}
