{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.brave;
in {
  options.modules.programs.brave = { enable = mkEnableOption "brave"; };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      commandLineArgs =
        [ "--enable-features=UseOzonePlatform" "--ozone-platform=wayland" ];
      package = pkgs.brave;
      extensions = [
        { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # i dont care about cookies
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        { id = "njdfdhgcmkocbgbhcioffdbicglldapd"; } # local cdn
        { id = "mpiodijhokgodhhofbcjdecpffjipkle"; } # single file
        { id = "jaoafjdoijdconemdmodhbfpianehlon"; } # skip redirect
        { id = "eneajgkmdhmjmloiabgkpkiooaejmlpk"; } # copy plain text
        { id = "nkgllhigpcljnhoakjkgaieabnkmgdkb"; } # dont fuck with paste
        { id = "ohnjgmpcibpbafdlkimncjhflgedgpam"; } # 4chanx
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # sponsor block
        { id = "nkbihfbeogaeaoehlefnkodbefgpgknn"; } # metamask
      ];
    };
  };
}
