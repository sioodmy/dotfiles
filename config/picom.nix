{ pkgs, config, ...}: 

{
    services.picom = {
        enable = true;
        shadow = false;
        shadowOpacity = "0.3";
        extraOptions = ''
            shadow-radius = 10;
            corner-radius = 10;
            round-borders = 1;
        '';
        fade = true;
        vSync = true;
        fadeDelta = 5;
    };
}
