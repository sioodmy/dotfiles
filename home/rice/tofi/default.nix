{
  pkgs,
  theme,
  ...
}: let
  tofi-emoji = pkgs.writeShellScriptBin "tofi-emoji" ''
    #!/bin/sh
    cat ${./emojis} | tofi --prompt-text "Emoji: " | awk '{print $1}' | tr -d '\n' | tee >(wl-copy) >(xargs -I % notify-send "% Emoji" "Emoji copied to clipboard")
  '';
in {
  home.packages = [pkgs.tofi tofi-emoji];
  xdg.configFile."tofi/config".text = with theme.colors; ''
    anchor = center
    width = 500
    height = 300
    horizontal = false
    font-size = 14
    prompt-text = "Run "
    font = monospace
    ascii-input = false
    outline-width = 5
    outline-color = #${surface0}
    border-width = 2
    border-color = #${accent}
    background-color = #${base}
    text-color = #${text}
    selection-color = #${accent}
    min-input-width = 120
    late-keyboard-init = true
    result-spacing = 10
    padding-top = 15
    padding-bottom = 15
    padding-left = 15
    padding-right = 15
  '';
}
