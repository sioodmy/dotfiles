{ config, pkgs, ... }: 
{
  home.packages = with pkgs; [
    ffmpegthumbnailer
    poppler_utils
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
  ];
  home.file.".config/lf/cleaner.sh" = {
    source = ./cleaner.sh;
    executable = true;
  };

  programs.lf = {
    enable = true;
    settings = {
      tabstop = 4;
      ratios = "1:2:1.5";
      promptfmt = "";
      icons = true;
      dirfirst = true;
      drawbox = false;
      preview = true;
      smartcase = true;
    };

    previewer.source = ./preview.sh;

    extraConfig = ''
      set cleaner ~/.config/lf/cleaner.sh
      &[[ -n "$ZLE_FIFO" ]] && lf -remote "send $id zle-init"
    '';

    keybindings = 
    { 
      gh = "cd ~"; 
      gd = "cd ~/download";
      gv = "cd ~/vids";
      gm = "cd ~/music";
      au = "unarchive";
#      "." = "set hidden!";
      "." = "zle-cd";
      a = "zle-insert-relative";
      A = "zle-insert-absolute";
      o = "&xdg-open $f";
    };

     commands = {
      open = ''
        ''${{
          case $(${ pkgs.file }/bin/file --mime-type $f -b) in
            text/* | */lfrc ) $EDITOR $fx;;
            *) for f in $fx; do devour xdg-open $f > /dev/null 2> /dev/null & done;;
          esac
        }}
      '';
    };
  };

}
