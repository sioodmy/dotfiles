{
  config,
  pkgs,
  ...
}: {
  users.users.sioodmy = {
    isNormalUser = true;
    # Enable ‘sudo’ for the user.
    extraGroups = [
      "wheel"
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
  };
}
