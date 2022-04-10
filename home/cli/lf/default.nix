{ config, pkgs, ... }: 
{
  home.packages = with pkgs; [
    ffmpegthumbnailer
    poppler_utils
    atool
    bat
    p7zip
    unzip
    catdoc
    gnumeric
    glow
    exiftool
    mcomix3
    odt2txt
    wkhtmltopdf
    imagemagick
    trash-cli
  ];
  home.file.".config/lf/cleaner.sh" = {
    source = ./cleaner.sh;
    executable = true;
  };

  programs.lf = {
    enable = true;
    settings = {
      tabstop = 4;
      ratios = "1:3:3";
      promptfmt = "";
      scrolloff = 10;
      icons = true;
      dirfirst = true;
      drawbox = false;
      preview = true;
      smartcase = true;
    };

    previewer.source = ./preview.sh;

    extraConfig = ''
      set cleaner ~/.config/lf/cleaner.sh
    '';

    keybindings = 
    { 
      gh = "cd ~"; 
      gd = "cd ~/download";
      gv = "cd ~/vids";
      x = "execute";
      gm = "cd ~/music";
      au = "extract";
      D = "%trash -i $f";
      "." = "set hidden!";
      a = "zle-insert-relative";
      A = "zle-insert-absolute";
      o = "open";
      e = "$$EDITOR $f";
      sh = "share";
      Y = "yank-path";
    };

     commands = {
       open = "&devour xdg-open \"$fx\"";
       execute = "$time $f && read -r line";
       mkdir = "%IFS=\" \"; mkdir -- \"$*\"";
       yank-path = "$printf '%s' \"$fx\" | xclip -i -selection clipboard && notify-send \"Files\" \"Path copied to clipboard!\"";
       share = "$curl -F\"file=@$fx\" https://0x0.st | xclip -selection c && notify-send \"Files\" \"Link copied to clipboard\"";
       extract = "$\{{
	clear; tput cup $(($(tput lines)/3)); tput bold
	set -f
	printf \"%s\\n\\t\" \"$fx\"
	printf \"extract?[y/N]\"
	read ans
	[ $ans = \"y\" ] && aunpack $fx
}}
       ";

       newfold = "$\{{
    set -f
    read newd
    printf \"Directory name: \"
    mkdir -- \"$newd\"
    mv -- $fx \"$newd\"
}}";
    };
  };

}
