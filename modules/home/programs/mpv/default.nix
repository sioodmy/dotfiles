{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.mpv;
in {
  options.modules.programs.mpv = { enable = mkEnableOption "mpv"; };

  config = mkIf cfg.enable {
    home.file.".config/mpv/scripts/mordenx.lua".source = ./mordenx.lua;
    home.file.".config/mpv/fonts/Material-Design-Iconic-Font.ttf".source = ./Material-Design-Iconic-Font.ttf;
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        mpris
        sponsorblock
        convert
        cutter
      ];
      config = {
        osc = false;
        border = false;
        fullscreen = false;
        keep-open = true;
        force-seekable = true;
        cursor-autohide = 100;
        osd-bar = false;
        osd-color = "#8aadf4";
        audio-file-auto = "fuzzy";
        volume = 80;
        volume-max = 100;
        demuxer-mkv-subtitle-preroll = true;
        sub-font-size = 52;
        sub-blur = 0.2;
        sub-color = "1.0/1.0/1.0/1.0";
        sub-margin-x = 100;
        sub-margin-y = 50;
        sub-shadow-color = "0.0/0.0/0.0/0.25";
        sub-shadow-offset = 0;
        alang = "ja,jp,jpn,en,eng,de,deu,ger,pol,pl";
        slang = "en,eng,pol,pl,de,deu,ger";
        screenshot-format = "png";
        screenshot-sw = true;
        screenshot-directory = "~/pics/ss";
        screenshot-template = "%f-%wH.%wM.%wS.%wT-#%#00n";
        correct-downscaling = true;
        linear-downscaling = true;
        linear-upscaling = true;
        sigmoid-upscaling = true;
        scale-antiring = 0.7;
        dscale-antiring = 0.7;
        cscale-antiring = 0.7;
        interpolation = true;
        gpu-api = "vulkan";
        hwdec = false;
        dither-depth = false;
      };
    };
  };
}
