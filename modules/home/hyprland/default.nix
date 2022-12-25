{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
  ocr = pkgs.writeShellScriptBin "ocr" ''
    #!/bin/bash
    grim -g "$(slurp -w 0 -b eebebed2)" /tmp/ocr.png && tesseract /tmp/ocr.png /tmp/ocr-output && wl-copy < /tmp/ocr-output.txt && notify-send "OCR" "Text copied!" && rm /tmp/ocr-output.txt -f
  '';
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    #!/bin/bash
    hyprctl keyword animation "fadeOut,0,8,slow" && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -w 0 -b 5e81acd2)" - | swappy -f -; hyprctl keyword animation "fadeOut,1,8,slow"
  '';
in {
  home.packages = with pkgs; [
    libnotify
    wf-recorder
    brightnessctl
    pamixer
    python39Packages.requests
    slurp
    tesseract5
    swappy
    ocr
    grim
    screenshot
    wl-clipboard
    pngquant
    cliphist
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default.override {
      nvidiaPatches = true;
    };
    systemdIntegration = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  services.wlsunset = {
    enable = true;
    latitude = "52.0";
    longitude = "21.0";
    temperature = {
      day = 6200;
      night = 3750;
    };
  };
  systemd.user.services = {
    swaybg = mkService {
      Unit.Description = "Wallpaper chooser";
      Service = {
        ExecStart = "${lib.getExe pkgs.swaybg} -i ${./wall.png}";
        Restart = "always";
      };
    };
    cliphist = mkService {
      Unit.Description = "Clipboard history";
      Service = {
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe pkgs.cliphist} store";
        Restart = "always";
      };
    };
  };
}
