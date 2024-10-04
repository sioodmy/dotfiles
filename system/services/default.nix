{...}: {
  services.syncthing = {
    enable = true;
    user = "sioodmy";
    dataDir = "/home/sioodmy/.config/syncthing";
    configDir = "/home/sioodmy/.config/syncthing";
    guiAddress = "127.0.0.1:8384";

    openDefaultPorts = true;
  };
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 1048576;
}
