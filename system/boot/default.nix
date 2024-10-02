{pkgs, ...}: {
  boot = {
    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
    };
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [
      # fix for suspend issues
      # see: https://www.reddit.com/r/archlinux/comments/e5oe4p/comment/fa8mzft/
      "snd_hda_intel.dmic_detect=0"
      "acpi_osi=linux"
    ];

    bootspec.enable = true;
    loader = {
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
        configurationLimit = 10;
        editor = false;
      };
      # spam space to get to boot menu
      timeout = 0;
    };
    loader.efi.canTouchEfiVariables = true;
  };
}
