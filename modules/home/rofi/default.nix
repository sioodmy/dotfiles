{
  config,
  pkgs,
  self,
  lib,
  ...
}: {
  xdg.configFile."rofi/minimal.rasi".source = ./config/minimal.rasi;
  xdg.configFile."rofi/calc.rasi".source = ./config/calc.rasi;
  xdg.configFile."rofi/emoji.rasi".source = ./config/emoji.rasi;
  programs.rofi = {
    enable = true;
    cycle = true;
    terminal = lib.getExe pkgs.foot;
    extraConfig = {
      modi = "drun,run,calc,emoji";
    };
    theme = "minimal";
    package = with pkgs;
      rofi-wayland.override {
        plugins = [
          rofi-calc
          (rofi-emoji.overrideAttrs (old: {
            postFixup = ''
              chmod +x $out/share/rofi-emoji/clipboard-adapter.sh
              wrapProgram $out/share/rofi-emoji/clipboard-adapter.sh \
                --prefix PATH ':' \
                  ${lib.makeBinPath (with pkgs; [libnotify wl-clipboard wtype])}
            '';
          }))
        ];
      };
  };
}
