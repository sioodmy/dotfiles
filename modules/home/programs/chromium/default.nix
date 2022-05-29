{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.chromium;
in {
  options.modules.programs.chromium = { enable = mkEnableOption "chromium"; };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
        { id = "abehfkkfjlplnjadfcjiflnejblfmmpj"; } # nord theme
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # sponsorblock
        { id = "dhdgffkkebhmkfjojejmpbldmpobfkfo"; } # tampermonkey
        { id = "ohnjgmpcibpbafdlkimncjhflgedgpam"; } # 4chanx
        {
          id = "dcpihecpambacapedldabdbpakmachpb";
          updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
        }
        {
          # chromium web store
          id = "ocaahdebbfolfmndjeplogmgcagdmblk";
          crxPath = builtins.fetchurl {
            name = "chromium-web-store.crx";
            url = "https://github.com/NeverDecaf/chromium-web-store/releases/download/v1.4.0/Chromium.Web.Store.crx";
            sha256 = "1bfzd02a9krkapkbj51kxfp4a1q5x2m2pz5kv98ywfcarbivskgs";
          };
          version = "1.4.0";
        }
        ];
        };

      };

    }
