{pkgs, ...}: {
  home.packages = with pkgs; [
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

    # neofetch but for cpu's
    cpufetch

    # neofetch but cooler
    pfetch-rs

    # download from yt and other websites
    yt-dlp

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
    rsync
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

    # syncthnig for acoustic people
    rsync

    figlet
    # Generate qr codes
    qrencode

    # script kidde stuff
    hcxdumptool
    hashcat
    # tshark
    # termshark
  ];
}
