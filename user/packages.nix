{
  pkgs,
  inputs,
  ...
}: let
  inherit (builtins) attrValues;
in {
  environment.systemPackages =
    attrValues {
      inherit
        (pkgs)
        ttyper
        mpv
        tdesktop
        flare-signal
        prismlauncher
        libreoffice-fresh
        vencord
        thunderbird-unwrapped
        brave
        rnote
        caprine
        ytmdl
        yt-dlp
        transmission_4-gtk
        nicotine-plus
        imv
        signal-desktop
        vesktop
        gimp3
        keepassxc
        clang
        gnumake
        cargo
        go
        gcc
        git
        ripgrep
        zoxide
        fzf
        eza
        gping
        dogdns
        onefetch
        cpufetch
        microfetch
        tealdeer
        glow
        hyperfine
        imagemagick
        ffmpeg-full
        catimg
        nmap
        xh
        grex
        jq
        rsync
        figlet
        qrencode
        unzip
        ;
    }
    ++ [inputs.zen-browser.packages.${pkgs.system}.default];
}
