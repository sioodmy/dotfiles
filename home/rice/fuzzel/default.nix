{
  pkgs,
  theme,
  ...
}:let
  emoji = pkgs.writeShellScriptBin "emoji" ''
    #!/bin/sh
    cat ${./emojis} | fuzzel -p"Emoji: " -d | awk '{print $1}' | tr -d '\n' | tee >(wl-copy) >(xargs -I % notify-send "% Emoji" "Emoji copied to clipboard")
  '';
in {
  home.packages = [emoji];
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "''${pkgs.foot}/bin/foot";
        icons-enabled = false;
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
