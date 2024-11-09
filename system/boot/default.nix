{...}: {
  boot = {
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    loader.systemd-boot.configurationLimit = 5;
  };
}
