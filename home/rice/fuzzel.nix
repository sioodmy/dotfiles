{
  pkgs,
  theme,
  ...
}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "''${pkgs.foot}/bin/foot";
      };
      border = {
        width = 3;
        radius = 7;
      };
      colors = with theme.colors; {
        background = "${base}ff";
        selection-text = "${accent}ff";
        selection-match = "${accent}ff";
        selection = "${surface0}ff";
        border = "${surface0}ff";
        text = "${overlay1}ff";
        match = "${text}ff";
      };
    };
  };
}
