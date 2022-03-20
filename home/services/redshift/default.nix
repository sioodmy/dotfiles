{ config, pkgs, ... }:

{
  services.redshift = {
    enable = true;

    # Warsaw
    latitude = 52.22977;
    longitude = 21.01178;
  };
}
