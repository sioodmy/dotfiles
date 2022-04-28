{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.services.fusuma;
in {
  options.modules.services.fusuma = { enable = mkEnableOption "fusuma"; };

  config = mkIf cfg.enable {
      home.packages = [ pkgs.xdotool ];
    services.fusuma = {

      enable = true;
          settings = {
            threshold = {
              swipe = 0.3;
              pinch = 0.1;
            };
            interval = {
              swipe = 0.5;
              pinch = 0.6;
            };
            swipe = {
              "3" = {
                right = {
                  command = "${pkgs.bspwm}/bin/bspc node -f west";
                };
                left = {
                  command = "${pkgs.bspwm}/bin/bspc node -f east";
                };
                up = {
                  command = "${pkgs.bspwm}/bin/bspc node -f south";
                };
                down = {
                  command = "${pkgs.bspwm}/bin/bspc node -f north";
                };
              };
              "4" = {
                right = {
                  command = "${pkgs.bspwm}/bin/bspc desktop --focus prev";
                };
                left = {
                  command = "${pkgs.bspwm}/bin/bspc desktop --focus next";
                };
              };
            };
          };
    };
  };
}
