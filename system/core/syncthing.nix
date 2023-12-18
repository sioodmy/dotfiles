_: {
  networking.firewall.allowedTCPPorts = [8384];
  services.syncthing = let
    hm = "/home/sioodmy";
  in {
    enable = true;
    systemService = true;
    user = "sioodmy";
    configDir = "${hm}/.config/syncthing";
    dataDir = "${hm}/.config/syncthing";
    openDefaultPorts = true;
    guiAddress = "127.0.0.1:8384";
    overrideFolders = true;
    overrideDevices = true;
  };

  # credits: Ramblurr
  # https://github.com/Ramblurr/nixcfg/blob/7343640bd4f5474eeba3b115424c2b0ccc809858/hosts/unstable/x86_64-linux/quine/syncthing.nix#L103
  # FIX: home-manager impermanence
  # when using with home-manager impermanence we need to ensure that home-manager activates before
  # syncthing. otherwise the syncthing init will create ~/.config/syncthing, but ~/.config will be created
  # with root:root ownership.
  systemd.services.syncthing.after = ["home-manager-sioodmy.service"];
  systemd.services.syncthing-init.after = ["home-manager-sioodmy.service"];
  # END FIX: home-manager impermanence
}
