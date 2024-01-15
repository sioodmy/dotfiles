{pkgs, theme, ...}: let
  tofi-emoji = pkgs.writeShellScriptBin "tofi-emoji" ''
    #!/bin/sh
    cat ${./emojis} | tofi --prompt-text "Emoji: " | awk '{print $1}' | tr -d '\n' | tee >(wl-copy) >(xargs -I % notify-send "% Emoji" "Emoji copied to clipboard")
  '';
  inherit (theme) x;
in {
  home.packages = [pkgs.tofi tofi-emoji];
  xdg.configFile."tofi/config".text = with theme.colors; ''
    anchor = top
    width = 100%
    height = 38
    horizontal = true
    font-size = 14
    prompt-text = "Run  "
    font = monospace
    ascii-input = false
    outline-width = 0
    border-width = 0
    background-color = #${base}cc
    text-color = ${x text}
    selection-color = #89b4fa
    min-input-width = 120
    late-keyboard-init = true
    result-spacing = 15
    padding-top = 5
    padding-bottom = 0
    padding-left = 5
    padding-right = 0
  '';
}
