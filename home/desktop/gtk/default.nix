{ pkgs, inputs, theme, ... }: {
  gtk = with theme.colors; {
    enable = true;
    theme = let
      phocus = pkgs.stdenvNoCC.mkDerivation {
        name = "phocus";
        src = inputs.phocus;
        postPatch = ''
          substituteInPlace scss/gtk-3.0/_colors.scss \
          --replace 0a0a0b ${ba} ${""/*Black*/} \
          --replace 141415 ${bg}  ${""/*LBlack*/} \
          --replace 1e1e20 ${c1}32  ${""/*LLBlack*/} \
          --replace 28282a ${c0}  ${""/*LLLBlack*/} \
          --replace 313135 ${c8}  ${""/*LLLLBlack*/} \
          --replace d65c5c ${c1}  ${""/*Red*/} \
          --replace d68f5c ${c9}  ${""/*LRed*/} \
          --replace d6cc5c ${c3}  ${""/*Yellow*/} \
          --replace 5cd68f ${c2}  ${""/*Green*/} \
          --replace 5cccd6 ${c6}  ${""/*Cyan*/} \
          --replace 5c5cd6 ${c4}  ${""/*Blue*/} \
          --replace 8f5cd6 ${c5}  ${""/*Magenta*/} \
          --replace d65cd6 ${c13} ${""/*LMagenta*/}
        '';
        patches = [ ./remove-npm-install.diff ./gradient.diff ];
        nativeBuildInputs = [ pkgs.nodePackages.sass pkgs.nodejs ];
        installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];

      };
    in {
      package = phocus;
      name = "phocus";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font.name = "Iosevka Nerd Font Mono";
  };
}
