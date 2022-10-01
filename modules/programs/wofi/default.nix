{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.wofi;
in {
  options.modules.programs.wofi = { enable = mkEnableOption "wofi"; };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.wofi ];
    home.file.".config/wofi/config".text = ''
      term=foot
      location=top
      yoffset=180
      width=400
      lines=15

      prompt=
      show=drun
      insensitive=true
      allow_images=false
      hide_scroll=true

      aways_parse_args=true
      show_all=true
    '';

    home.file.".config/wofi/style.css".text = ''
      * {
        all: unset;
        font-family: sans-serif;
        font-size: 18px;
      }

      #window {
        background-color: #2e3440;
        border-radius: 12px;
      }

      #outer-box {
        background-color: #2e3440;
        border: 4px solid #434c5e;
        border-radius: 12px;
      }

      #input {
        margin: 1rem;
        padding: 0.5rem;
        border-radius: 10px;
        background-color: #3b4252;
      }

      #entry {
        margin: 0.25rem 0.75rem 0.25rem 0.75rem;
        padding: 0.25rem 0.75rem 0.25rem 0.75rem;
        color: #d8dee9;
        text-align: center;
        width: 100%;
        border-radius: 8px;
      }

      #entry:selected {
        background-color: #3b4252;
        color: #eceff4;
      }
    '';
  };
}
