{...}: {
  imports = [
    ./net
    ./disks
    ./boot
    ./fonts
    ./audio
    ./users
    ./wayland
    ./nix
    #    ./security
    ./services
  ];

  environment.etc.machine-id.text = "796f7520617265206175746973746963";
  time.timeZone = "Europe/Warsaw";
  system.stateVersion = "24.11";
}
