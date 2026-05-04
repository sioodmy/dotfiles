{
    everforest-gtk-theme,
    fetchFromGitHub,
    gtk3,
    gtk4,
    sassc,
    ...
}: everforest-gtk-theme.overrideAttrs (old: {
    src = fetchFromGitHub {
        owner = "imnotpoz";
        repo = "Everforest-GTK-Theme";
        rev = "f9be45b024e29efa6082cdfe6f47ca6b1110f20a";
        hash = "sha256-m/10CEHyTKp1OHd9X4PZghF12SDJtKJpH6qXooyAdJo=";
    };

    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [
        sassc
        gtk3
        gtk4
    ];

    postPatch = /*sh*/''
        ${old.postPatch or ""}

        patchShebangs themes/install.sh
    '';

    installPhase = /*sh*/''
        runHook preInstall

        mkdir -p "$out/share/"{themes,icons}

        cp -a icons/* "$out/share/icons/"

        for theme in "$out/share/icons/"*; do
            gtk-update-icon-cache $theme
            gtk4-update-icon-cache $theme
        done

        cd themes
        ./install.sh --name Everforest --theme all --dest "$out/share/themes"
        cd ..

        runHook postInstall
    '';

    # thanks Sw3d15h-F1s4
    # https://github.com/Sw3d15h-F1s4/nixos/blob/9853e3e40ebf3d430f9e3a8bc6ded7563f671281/modules/home-manager/features/gtk-themes.nix#L12
    dontFixup = true;

    dontDropIconThemeCache = true;
})
