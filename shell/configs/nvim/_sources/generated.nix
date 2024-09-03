# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
  dockerTools,
}: {
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
    version = "206241e451c12f78969ff5ae53af45616ffc9b72";
    src = fetchFromGitHub {
      owner = "nvim-neo-tree";
      repo = "neo-tree.nvim";
      rev = "206241e451c12f78969ff5ae53af45616ffc9b72";
      fetchSubmodules = false;
      sha256 = "sha256-eNGuQEjAKsPuRDGaw95kCVOmP64ZDnUuFBppqtcrhZ4=";
    };
    date = "2024-06-11";
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
  org-bullets = {
    pname = "org-bullets";
    version = "7e76e04827ac3fb13fc645a6309ac14203c4ca6a";
    src = fetchFromGitHub {
      owner = "nvim-orgmode";
      repo = "org-bullets.nvim";
      rev = "7e76e04827ac3fb13fc645a6309ac14203c4ca6a";
      fetchSubmodules = false;
      sha256 = "sha256-bxiL88uUa0Zd/HL7RcC/XVhbkgdlFr6MmlQfkpxFybE=";
    };
    date = "2024-07-09";
  };
  recession = {
    pname = "recession";
    version = "e087ebeef81df25a12fcc4ec067ca73e2bb54c4a";
    src = fetchFromGitHub {
      owner = "stevearc";
      repo = "resession.nvim";
      rev = "e087ebeef81df25a12fcc4ec067ca73e2bb54c4a";
      fetchSubmodules = false;
      sha256 = "sha256-Id7rJwxvH81TnBKHAsPuP8nmu7SS6b5PiLoE2UzeRX0=";
    };
    date = "2024-07-01";
  };
  scope = {
    pname = "scope";
    version = "5e3f5ead970317b2f276d38dc031cb4bc5742cd4";
    src = fetchFromGitHub {
      owner = "tiagovla";
      repo = "scope.nvim";
      rev = "5e3f5ead970317b2f276d38dc031cb4bc5742cd4";
      fetchSubmodules = false;
      sha256 = "sha256-JisbhQ5oRPBl+C33xbRu6GzK71DstSOHrHwLwpecnVA=";
    };
    date = "2024-07-30";
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
  telescope-orgmode = {
    pname = "telescope-orgmode";
    version = "2cd2ea778726c6e44429fef82f23b63197dbce1b";
    src = fetchFromGitHub {
      owner = "nvim-orgmode";
      repo = "telescope-orgmode.nvim";
      rev = "2cd2ea778726c6e44429fef82f23b63197dbce1b";
      fetchSubmodules = false;
      sha256 = "sha256-yeGdy1aip4TZKp++MuSo+kxo+XhFsOT0yv+9xJpKEps=";
    };
    date = "2024-08-01";
  };
}