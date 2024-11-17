{...}: {
  boot = {
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        editor = false;
      };
      # spam space to get to boot menu
      timeout = 0;
    };
  };
}
