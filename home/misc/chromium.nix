{
  lib,
  pkgs,
  ...
}: {
  programs.chromium = {
    package = pkgs.ungoogled-chromium;
    enable = true;
    extensions = let
      createChromiumExtensionFor = browserVersion: {
        id,
        sha256,
        version,
      }: {
        inherit id;
        crxPath = builtins.fetchurl {
          url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
          name = "${id}.crx";
          inherit sha256;
        };
        inherit version;
      };
      createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
    in [
      (createChromiumExtension {
        # ublock origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
        sha256 = "sha256:1q1wxcp27dkn9khn52fk8k3mli6wx10wf3p260bdk692ca0ijy2i";
        version = "1.54.0";
      })
      (createChromiumExtension {
        # dark reader
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
        sha256 = "sha256:0mba3n0pqsvb0l8ln5mk3xf7n5ahyz7ig9vm51v55v7cw1dxlmma";
        version = "4.9.73";
      })
      (createChromiumExtension {
        # metamask
        id = "nkbihfbeogaeaoehlefnkodbefgpgknn";
        sha256 = "sha256:1yxvjkpmnl9mpjs0ycj0wib16kzpw1xbsr9jmrrkap2kn2anzvin";
        version = "11.7.0";
      })
      (createChromiumExtension {
        # catppuccin theme
        id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";
        sha256 = "sha256:10f7szaf0al7i9i0kcfpwg7xz0ms1h9mpsm92mscvx24ydvdswki";
        version = "4.1";
      })
      (createChromiumExtension {
        # I still don't care about cookies
        id = "edibdbjcniadpccecjdfdjjppcpchdlm";
        sha256 = "sha256:1jv84z0186nblwq5977fcqcah729xkj25lir03jj1whn951nvkpb";
        version = "1.1.1";
      })
    ];
  };
}
