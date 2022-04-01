{ pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # cli tools
    exa ffmpeg unzip xclip fetch
    libnotify gnupg update-nix-fetchgit yt-dlp ytmdl
    ripgrep rsync imagemagick
    scrot bottom newsboat unrar
    tealdeer cava killall onefetch
    todo du-dust
    # gui apps
    obs-studio mpv sxiv tdesktop
    transmission-gtk pavucontrol pcmanfm
    # unfree apps (sorry daddy stallman)
    discord minecraft steam
    # dev tools
    python3 git jdk dconf gcc rustc rustfmt cargo
  ];
}
