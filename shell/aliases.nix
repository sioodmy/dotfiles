{pkgs, ...}: let
  getExe = pkgs.lib.getExe;
in
  with pkgs; rec {
    l = "${getExe eza} --icons";
    e = "${getExe eza} --icons -lha --git";

    ls = l;
    la = e;

    m = "mkdir";

    g = "git";
    n = "nix";

    ytmp3 = "yt-dlp -x --embed-metadata --audio-quality 0 --audio-format mp3";

    cat = "${getExe bat}";
    fzf = "${getExe skim}";

    cp = "cp -ivr";
    mv = "mv -iv";

    kys = "shutdown now";

    gpl = "curl https://www.gnu.org/licenses/gpl-3.0.txt -o LICENSE";

    gcb = "git checkout";
    gd = "git pull";
    gu = "git push";
    gc = "git commit";
    ga = "git add";
  }
