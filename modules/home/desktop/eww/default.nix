{ inputs, lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.eww;
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

    home.file.".config/eww/scripts/volume.sh" = {
      source = ./scripts/volume.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/brightness.sh" = {
      source = ./scripts/brightness.sh;
      executable = true;
    };
    home.file.".config/eww/scripts/ss.sh" = {
      source = ./scripts/ss.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/workspaces.sh" = {
      source = ./scripts/workspaces.sh;
      executable = true;
    };

    services.sxhkd.keybindings = {
      "XF86AudioRaiseVolume" =
        ''eww update volumepoll="$(~/.config/eww/scripts/volume.sh up)"'';
      "XF86AudioLowerVolume" =
        ''eww update volumepoll="$(~/.config/eww/scripts/volume.sh down)"'';
      "XF86AudioMicMute" = ''
        eww update micvolumepoll="$(~/.config/eww/scripts/micvolume.sh toggle)"'';
      "XF86AudioMute" =
        ''eww update volumepoll="$(~/.config/eww/scripts/volume.sh toggle)"'';
      "XF86MonBrightnessUp" =
        "eww update brightnesspoll=$(~/.config/eww/scripts/brightness.sh up)";
      "XF86MonBrightnessDown" =
        "eww update brightnesspoll=$(~/.config/eww/scripts/brightness.sh down)";
      "super + b" = "eww open --toggle bar";
      "Print" = "~/.config/eww/scripts/ss.sh menu";
    };
  };
}
