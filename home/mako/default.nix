{ config, lib, pkgs, ... }: {

  programs.mako = {
    enable = true;

    backgroundColor = "#303446";
    textColor = "#c6d0f5";
    borderColor = "#8caaee";
    padding = "15";
    defaultTimeout = 7000;
    borderSize = 3;
    borderRadius = 10;
    height = 300;
    font = "monospace 15";

    extraConfig = ''
      [urgency=high]
      border-color=#ef9f76
    '';

  };
}
