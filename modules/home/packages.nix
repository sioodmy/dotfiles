{ inputs, pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    inputs.todo.packages."${system}".todo
    maim 
    # cli tools
    exa ffmpeg unzip xclip 
    libnotify gnupg yt-dlp 
    ripgrep rsync imagemagick
    scrot newsboat unrar
    tealdeer killall onefetch
    du-dust 
    # gui apps
    obs-studio mpv sxiv tdesktop
    transmission-gtk pavucontrol pcmanfm
    # unfree apps (sorry daddy stallman)
    minecraft 
    # dev tools
    python3 git jdk dconf gcc rustc rustfmt cargo
  ];
}
