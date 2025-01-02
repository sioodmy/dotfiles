# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  incline = {
    pname = "incline";
    version = "16fc9c073e3ea4175b66ad94375df6d73fc114c0";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "incline.nvim";
      rev = "16fc9c073e3ea4175b66ad94375df6d73fc114c0";
      fetchSubmodules = false;
      sha256 = "sha256-5DoIvIdAZV7ZgmQO2XmbM3G+nNn4tAumsShoN3rDGrs=";
    };
    date = "2024-05-16";
  };
  neotree = {
    pname = "neotree";
    version = "2a0b2c5d394a280cee9444c9894582ac53098604";
    src = fetchFromGitHub {
      owner = "nvim-neo-tree";
      repo = "neo-tree.nvim";
      rev = "2a0b2c5d394a280cee9444c9894582ac53098604";
      fetchSubmodules = false;
      sha256 = "sha256-S/YbF7B/B76jdf6+Yf+uCsQqQTR+Yr72JzYmQTT4KJk=";
    };
    date = "2024-12-31";
  };
  nvim-base-16 = {
    pname = "nvim-base-16";
    version = "6ac181b5733518040a33017dde654059cd771b7c";
    src = fetchFromGitHub {
      owner = "RRethy";
      repo = "nvim-base16";
      rev = "6ac181b5733518040a33017dde654059cd771b7c";
      fetchSubmodules = false;
      sha256 = "sha256-GRF/6AobXHamw8TZ3FjL7SI6ulcpwpcohsIuZeCSh2A=";
    };
    date = "2024-05-23";
  };
  scope = {
    pname = "scope";
    version = "e1799fa37178382fc228245c41af5547e3f95182";
    src = fetchFromGitHub {
      owner = "tiagovla";
      repo = "scope.nvim";
      rev = "e1799fa37178382fc228245c41af5547e3f95182";
      fetchSubmodules = false;
      sha256 = "sha256-rOuEDd90dMRCa+zikTQdE+D4rpx4PFmsk8JpvjK1b7E=";
    };
    date = "2024-12-20";
  };
  sixelpreview = {
    pname = "sixelpreview";
    version = "6292991a005e1a367095f4d404405a626c82b49f";
    src = fetchFromGitHub {
      owner = "sioodmy";
      repo = "sixelpreview.nvim";
      rev = "6292991a005e1a367095f4d404405a626c82b49f";
      fetchSubmodules = false;
      sha256 = "sha256-0jwSRuLHSHzeCKk+EdyhhlNLsZYRfJI6hxW4UCNn3uc=";
    };
    date = "2024-08-11";
  };
}