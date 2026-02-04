{
  pkgs,
  inputs,
  ...
}:
let
  inherit (builtins)
    attrValues
    readDir
    readFile
    attrNames
    ;
  inherit (pkgs.lib) forEach;
  scripts =
    readDir ./scripts |> attrNames |> map (x: pkgs.writeShellScriptBin x (readFile ./scripts/${x}));
in
{
  environment.systemPackages =
    attrValues {
      inherit (pkgs)
        waybar
        anki
        clang-tools
        rust-analyzer
        firefox-devedition
        bear
        pastel
        nixfmt
        nixfmt-tree
        yazi
        alejandra
        wmenu
        ollama
        pandoc
        texliveMedium
        vscode-langservers-extracted
        tectonic-unwrapped
        typst
        texlab
        powershell
        niri
        audacity
        geteduroam-cli
        libreoffice-qt6-fresh
        ttyper
        pavucontrol
        grim
        slurp
        wl-clipboard
        quickshell
        mpv
        flare-signal
        vencord
        rnote
        caprine
        ytmdl
        swaybg
        yt-dlp
        transmission_4-gtk
        nicotine-plus
        imv
        signal-desktop
        vesktop
        gimp3
        inkscape
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
        onefetch
        cpufetch
        microfetch
        tealdeer
        glow
        hyperfine
        imagemagick
        ffmpeg-full
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
    ++ scripts;
    # ++ [ inputs.helium-browser.packages."${pkgs.system}".helium ];
}
