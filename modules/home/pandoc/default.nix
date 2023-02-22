{
  config,
  pkgs,
  ...
}: let
  texlive = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-small
      noto
      mweights
      cm-super
      cmbright
      fontaxes
      beamer
      ;
  };
in {
  home.packages = [texlive pkgs.pandoc];
}
