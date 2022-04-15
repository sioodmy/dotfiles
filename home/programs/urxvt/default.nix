{ pkgs, lib, config, theme, ... }:
with lib;
let cfg = config.modules.programs.urxvt;
in {
  options.modules.programs.urxvt = { enable = mkEnableOption "urxvt"; };

  config = mkIf cfg.enable {
    programs.urxvt = with theme.colors; {
      enable = true;
      fonts = [ "xft:monospace:size=15,xft:Twitter Color Emoji:size=15" ];
      scroll = {
        bar.enable = false;
        keepPosition = true;
        lines = 10000;
        scrollOnKeystroke = true;
        scrollOnOutput = false;
      };
      shading = 88;
      extraConfig = { "internalBorder" = 24; };
    };
  };
}
