{pkgs, ...}:
with pkgs; [
  # better cd
  zoxide
  # drop in replacement for fzf
  skim

  # Tbh should be preinstalled
  gnumake
  # Runs programs without installing them
  comma

  # grep replacement
  ripgrep

  # ping, but with cool graph
  gping

  # dns client
  dogdns

  # neofetch but for git repos
  onefetch

  git

  # neofetch but for cpu's
  cpufetch

  # download from yt and other websites
  yt-dlp

  # man pages for tiktok attention span mfs
  tealdeer

  # markdown previewer
  glow

  # profiling tool
  hyperfine

  # gimp for acoustic people
  imagemagick

  # premiere pro for acoustic people
  ffmpeg-full

  # preview images in terminal
  catimg

  # networking stuff
  nmap
  wget

  # faster find
  fd

  # http request thingy
  xh

  # generate regex
  grex

  # todo app for acoustic people (wrriten by me :3)
  todo

  # json thingy
  jq

  # docs
  pandoc

  # syncthnig for acoustic people
  rsync

  dconf

  figlet
  # Generate qr codes
  qrencode

  unzip

  zig
]
