{
  lib,
  callPackage,
  fetchpatch,
  fetchurl,
  stdenv,
  pkgsi686Linux,
}: let
  generic = args: let
    imported = import ./generic.nix args;
  in
    callPackage imported {
      lib32 =
        (pkgsi686Linux.callPackage imported {
          libsOnly = true;
          kernel = null;
        })
        .out;
    };

  kernel =
    callPackage # a hacky way of extracting parameters from callPackage
    
    ({
      kernel,
      libsOnly ? false,
    }:
      if libsOnly
      then {}
      else kernel)
    {};
in rec {
  # Policy: shoot ourselves in the foot :)
  unfucked = generic {
    version = "515.65.01";
    sha256_64bit = "sha256-BJLdxbXmWqAMvHYujWaAIFyNCOEDtxMQh6FRJq7klek=";
    openSha256 = "sha256-GCCDnaDsbXTmbCYZBCM3fpHmOSWti/DkBJwYrRGAMPI=";
    settingsSha256 = "sha256-kBELMJCIWD9peZba14wfCoxsi3UXO3ehFYcVh4nvzVg=";
    persistencedSha256 = "sha256-P8oT7g944HvNk2Ot/0T0sJM7dZs+e0d+KwbwRrmsuDY=";
    patches = [../patches/nvidia-kernel-6.0.patch];
  };
}
