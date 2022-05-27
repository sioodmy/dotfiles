{ lib, pkgs, ... }:

let
  baseUrl = "https://raw.githubusercontent.com/StevenBlack/hosts";
  commit = "c8ed1f1f0bbd59eb5e152406541e9813feed4873";
  hostsFile = pkgs.fetchurl {
    url = "${baseUrl}/${commit}/alternates/fakenews-gambling/hosts";
    sha256 = "bjloQC25uOH3K+5XVTrKvu5mOZDtKipcU8k1Mn8Os7U=";
  };
  hostsContent = lib.readFile hostsFile;
in {
  networking.extraHosts = hostsContent + ''
  '';
}
