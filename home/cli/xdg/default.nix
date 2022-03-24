{ pkgs, config, ... }:

{

  xdg.userDirs = {
    enable = true;
    documents = "$HOME/other";
    download = "$HOME/download";
    videos = "$HOME/vids";
    music = "$HOME/music";
    pictures = "$HOME/pics";
    desktop = "$HOME/other";
    publicShare = "$HOME/other";
    templates = "$HOME/other";
  };
}
