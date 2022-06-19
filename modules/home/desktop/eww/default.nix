{ inputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.desktop.eww;
  bright = pkgs.writeShellScriptBin "bright" ''${builtins.readFile ./scripts/brightness.sh}'';
  volume = pkgs.writeShellScriptBin "volume" ''${builtins.readFile ./scripts/volume.sh}'';
in {
  options.modules.desktop.eww = {
    enable = mkEnableOption "eww";
  };

  config = mkIf cfg.enable {
    # eww package
    home.packages = [
      inputs.eww.packages."x86_64-linux".eww
      pkgs.pamixer
      pkgs.tdrop
      pkgs.libcanberra-gtk3
      pkgs.tiramisu
      pkgs.brightnessctl
      bright
      volume
    ];

    # configuration
    home.file.".config/eww/eww.yuck".source = ./eww.yuck;

    home.file.".config/eww/eww.scss".source = ./eww.scss;

    # scripts

    home.file.".config/eww/scripts/battery.sh" = {
      source = ./scripts/battery.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/wifi.sh" = {
      source = ./scripts/wifi.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/brightness.sh" = {
      source = ./scripts/brightness.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/workspaces.sh" = {
      source = ./scripts/workspaces.sh;
      executable = true;
    };


    services.sxhkd.keybindings = {
      "XF86AudioRaiseVolume" =
        ''pamixer --increase 5 --unmute && volume &'';
      "XF86AudioLowerVolume" =
        ''pamixer --decrease 5 --unmute && volume &'';
      "XF86AudioMute" =
        ''pamixer --toggle && volume'';
      "XF86MonBrightnessUp" =
        "brightnessctl set +5% && bright &";
      "XF86MonBrightnessDown" =
        "brightnessctl set 5%- && bright &";
      "super + b" = "eww open --toggle bar";
      "Print" = "~/.config/eww/scripts/ss.sh menu";
    };
  };
}
