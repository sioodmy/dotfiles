{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  home.packages = with pkgs; let
    emoji = pkgs.writeShellScriptBin "emoji" ''
      #!/bin/sh
      chosen=$(cut -d ';' -f1 ${./emoji} | tofi | sed "s/ .*//")
      [ -z "$chosen" ] && exit
      if [ -n "$1" ]; then
      	wtype "$chosen"
      else
      	printf "$chosen" | wl-copy
      	notify-send "'$chosen' copied to clipboard." &
      fi
    '';
  in [
    # for compatibility sake
    (writeScriptBin "dmenu" ''exec ${lib.getExe tofi}'')
    tofi
    emoji
    wtype
  ];

  xdg.configFile."tofi/config".text = ''
    font = Iosevka Nerd Font
    font-size = 13
    horizontal = true
    anchor = top
    width = 100%
    height = 40
    outline-width = 0
    border-width = 0
    min-input-width = 120
    result-spacing = 30
    padding-top = 10
    padding-bottom = 10
    padding-left = 20
    padding-right = 0
    prompt-text = " "
    prompt-padding = 30
    background-color = #1e1e2e
    text-color = #cdd6f4
    prompt-color = #1e1e2e
    prompt-background = #89b4fa
    prompt-background-padding = 4, 10
    prompt-background-corner-radius = 12
    input-background = #313244
    input-background-padding = 4, 10
    input-background-corner-radius = 12
    selection-color = #1e1e2e
    selection-background = #89b4fa
    selection-background-padding = 4, 10
    selection-background-corner-radius = 12
    selection-match-color = #bac2de
    clip-to-padding = false
  '';
}
