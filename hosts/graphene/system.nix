{ pkgs, system, config, ... }: {
  hardware.nvidia.modesetting.enable = true;
  programs.steam.enable = true;

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --rate 144 --mode 1920x1080
    '';
  };
}
