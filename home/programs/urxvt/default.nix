{ pkgs, config, theme, ... }:
{
    programs.urxvt = with theme.colors; {
        enable = true;
        fonts = [ "xft:${font}:size=15,xft:Twitter Color Emoji:size=15" ];
        scroll = {
            bar.enable = false;
            keepPosition = true;
            lines = 10000;
            scrollOnKeystroke = true;
            scrollOnOutput = false;
        };
        shading = 88;
        extraConfig = {
            "internalBorder" = 24;
        };
    };
}
