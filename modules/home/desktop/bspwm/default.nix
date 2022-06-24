{ config, pkgs, lib, fetchurl, ... }:

with lib;
let
  cfg = config.modules.desktop.bspwm;
  floatworkspace =
    pkgs.writeShellScriptBin "floatworkspace" "${builtins.readFile ./float.sh}";

in {
  options.modules.desktop.bspwm = { enable = mkEnableOption "bspwm"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ feh floatworkspace ];

    home.file.".local/backgrounds/wallpaper.png".source = ../wall.png;

    home.keyboard = {
      layout = "pl";
      options = [ "caps:escape" ];
    };

    home.pointerCursor = {
      package = pkgs.catppuccin-cursors;
      name = "Catppuccin-Dark-Cursors";
      size = 32;
    };

    xsession = {
      enable = true;
      windowManager.bspwm = {
        enable = true;
        startupPrograms = [
          "feh --bg-fill ~/.local/backgrounds/wallpaper.png"
          "xsetroot -cursor_name left_ptr"
          "eww daemon && eww open bar"
          "floatworkspace"
        ];
        settings = with theme.colors; {
          remove_disabled_monitors = true;
          remove_unplugged_monitors = true;
          ignore_ewmh_focus = true;
          focus_follows_pointer = true;
          pointer_follows_focus = false;
          border_width = 0;
          window_gap = 15;
          focused_border_color = "#8aadf4";
          split_ratio = 0.618;
          urgent_border_color = "#ed8796";
          normal_border_color = "#5b6078";
          presel_feedback_color = "#f4dbd6";
        };
        monitors = { "focused" = [ "1" "2" "3" "4" "5" ]; };

        extraConfig = ''
        bspc rule -a "*:Toolkit:Picture-in-Picture" \
        state=floating sticky=on follow=off focus=on \
        '';
        rules = {
          "Zathura" = { state = "tiled"; };
          "Pavucontrol" = { state = "floating"; };
          "Thunar" = { state = "floating"; };
          "pavucontrol" = { state = "floating"; };
          "transmission-gtk" = { state = "floating"; };
          "Firefox" = {
            desktop = "^2";
            follow = true;
            state = "tiled";
          };
          "csgo_linux64" = {
            desktop = "^4";
            follow = true;
          };
          "steam" = {
            desktop = "^4";
            follow = false;
            state = "floating";
          };
          "minecraft-launcher" = {
            desktop = "^4";
            follow = true;
            state = "floating";
            center = true;
          };
          "Discord" = {
            desktop = "^3";
            follow = true;
          };
          "telegram-desktop" = {
            desktop = "^3";
            follow = true;
          };
          "keepassxc" = {
            state = "floating";
          };
        };
      };
    };
    services.sxhkd.keybindings = {
      "super + alt + {q,r}" = "bspc {quit,wm -r}";
      "alt + control + shift + {h,j,k,l}" =
        "e -z {left -30 0 || bspc node -z right -30 0, bottom 0 20 || bspc node -z top 0 30, top 0 -30 || bspc node -z bottom 0 -30, right 30 0 || bspc node -z left 30 0}";
      "super + {_,shift + }minus" = "bspc node -{c,k}";
      "super + m" = "bspc desktop -l next";
      "super + y" = "bspc node newest.marked.local -n newest.!automatic.local";
      "super + g" = "bspc node -s biggest.window";
      "super + {t,shift + t,s,f}" =
        "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
      "super + ctrl + {m,x,y,z}" =
        "bspc node -g {marked,locked,sticky,private}";
      "super + {_,shift + }{h,j,k,l}" =
        "bspc node -{f,s} {west,south,north,east}";
      "super + {p,b,comma,period}" =
        "bspc node -f @{parent,brother,first,second}";
      "super + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";
      "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";
      "super + {grave,Tab}" = "bspc {node,desktop} -f last";
      "super + {o,i}" = "bspc wm -h off; bspc wm -h off; bspc wm -h on";
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
      "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
      "super + ctrl + space" = "bspc node -p cancel";
      "super + ctrl + shift + space" =
        "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
      "super + alt + {h,j,k,l}" =
        "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "super + alt + shift + {h,j,k,l}" =
        "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
      "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
    };

  };

}
