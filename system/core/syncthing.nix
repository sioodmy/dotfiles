{...}: {
  services.syncthing = {
    enable = true;
    user = "sioodmy";
    dataDir = "/persist/home/sioodmy/.config/syncthing";
    configDir = "/persist/home/sioodmy/.config/syncthing";
    guiAddress = "127.0.0.1:8384";

    openDefaultPorts = true;
  };
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 1048576;

  # yet another hacky workaround for race condition with impermanence
  # https://github.com/nix-community/impermanence/issues/94
  systemd.services.syncthing.serviceConfig.Type = "idle";
}
