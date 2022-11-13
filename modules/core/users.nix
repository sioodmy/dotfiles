{
  config,
  pkgs,
  ...
}: {
  users.users.sioodmy = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gitea"
      "systemd-journal"
      "audio"
      "wireshark"
      "video"
      "input"
      "lp"
      "networkmanager"
    ];
    uid = 1000;
    shell = pkgs.zsh;
    initialPassword = "changeme";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9ExEl6WqtCI4yCqbSAhAGmzvVp/nYADbgy/Qi4AKQy sioodmy@anthe"];
  };
}
