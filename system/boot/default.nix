{pkgs, ...}: {
  boot = {
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
  };
}
