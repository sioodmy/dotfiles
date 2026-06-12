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
        ags
        deluge
        clang-tools
        antigravity
        code-cursor
        rink
        prismlauncher
        ironbar
        glfw3-minecraft
        jdk17
        jre21_minimal
        brave
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
        ttyper
        pwvucontrol
        grim
        cliphist
        slurp
        wl-clipboard
        flare-signal
        vencord
        rnote
        caprine
        swaybg
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
      inherit (inputs.glide-browser.packages.${pkgs.stdenv.system})
        glide-browser-bin
        ;
      inherit (inputs.qml-niri.packages.${pkgs.stdenv.system})
        quickshell
        ;
      inherit (inputs.vim.packages.${pkgs.stdenv.system})
        default
        ;
    }
    ++ [ inputs.helium-browser.packages.${pkgs.system}.default ]
    ++ scripts;
}
