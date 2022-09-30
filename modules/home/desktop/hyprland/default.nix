{ pkgs, lib, config, fetchzip, inputs, stdenv, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
  mkService = lib.recursiveUpdate {
    Unit.PartOf = [ "graphical-session.target" ];
    Unit.After = [ "graphical-session.target" ];
    Install.WantedBy = [ "graphical-session.target" ];
  };
  ocr = pkgs.writeShellScriptBin "ocr" ''
    #!/bin/bash
    grim -g "$(slurp -w 0 -b eebebed2)" /tmp/ocr.png && tesseract /tmp/ocr.png /tmp/ocr-output && wl-copy < /tmp/ocr-output.txt && notify-send "OCR" "Text copied!" && rm /tmp/ocr-output.txt -f
  '';

in {
  options.modules.desktop.hyprland = { enable = mkEnableOption "hyprland"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swaybg
      brightnessctl
      pamixer
      python39Packages.requests
      sway-contrib.grimshot
      slurp
      tesseract5
      ocr
      grim
      wlogout
    ];

    home.pointerCursor = {
      package = pkgs.catppuccin-cursors;
      name = "Catppuccin-Dark-Cursors";
      size = 16;
    };
    home.pointerCursor.gtk.enable = true;

    services.gammastep = {
      enable = true;
      provider = "geoclue2";
    };

    systemd.user.services = {
      swaybg = mkService {
        Unit.Description = "Wallpaper chooser";
        Service.ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${./wall.png}";
      };
    };
  };
}
