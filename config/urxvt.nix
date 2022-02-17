{ pkgs, config, ... }:
{
    programs.urxvt = {
        enable = true;
        fonts = [ "xft:JetBrainsMono Nerd Font Mono:size=15" ];
        scroll = {
            bar.enable = false;
            keepPosition = true;
            lines = 10000;
            scrollOnKeystroke = true;
            scrollOnOutput = false;
        };

        extraConfig = {
            "internalBorder" = 24;
        };
    };
}
