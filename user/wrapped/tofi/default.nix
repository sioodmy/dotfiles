{
  pkgs,
  theme,
  ...
}:
let
  config = pkgs.writeText "tofi-config" (
    pkgs.lib.generators.toKeyValue { } {
      prompt-text = "> ";
      font = "monospace";
      ascii-input = false;
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 5;
      background-color = "#000A";
      default-result-color = "#e0def4";
      prompt-color = "#e0def4";
      selection-color = "#c4a7e7";
    }
  );
in
pkgs.symlinkJoin {
  name = "tofi-wrapped";
  paths = [
    pkgs.tofi
  ]
  ++ (import ./scripts.nix { inherit pkgs; });
  buildInputs = [ pkgs.makeWrapper ];
  # we don't want to wrap tofi-emoji, yet we want it wrapped in the same package
  # NOTE: {this,type,of} syntax is undefined in posix :c
  postBuild = ''
    wrapProgram $out/bin/tofi --add-flags "--config ${config}";
    wrapProgram $out/bin/tofi-run --add-flags "--config ${config}";
    wrapProgram $out/bin/tofi-drun --add-flags "--config ${config}";
  '';
}
