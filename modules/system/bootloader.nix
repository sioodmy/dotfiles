{ pkgs, config, ... }:

{
  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
      theme = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "grubb";
        rev = "3f62cd4174465631b40269a7c5631e5ee86dec45";
        sha256 = "d15FS7R78kdUKqC7EAei5Pe0Vuj2boVnm4WZYQdPURo=";
      } + "/catppuccin-grub-theme";
    };
  };
}
