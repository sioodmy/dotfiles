{ pkgs, ...}:
let 
 tofi-emoji = pkgs.writeShellScriptBin "tofi-emoji" ''
   #!/bin/sh
   cat ${./emojis} | tofi --prompt-text " Emoji: "| awk '{print $1}' || tr -d '\n' | tee >(wl-copy) >(xargs -I % notify-send "% Emoji" "Emoji copied to clipboard")
 '';
in
{
 home.packages = [ pkgs.tofi tofi-emoji];
 xdg.configFile."tofi/config".source = ./config;
}
