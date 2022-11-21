{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
    ];

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  hardware = {
    nvidia = {
      open = true;
      powerManagement.enable = true;
      modesetting.enable = true;
    };
    opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
  };
}
