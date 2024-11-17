{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber = {
      enable = true;
      extraConfig = {
        # workaround for high battery usage
        "10-disable-camera" = {
          "wireplumber.profiles" = {
            main = {
              "monitor.libcamera" = "disabled";
            };
          };
        };
      };
    };
    pulse.enable = true;
    jack.enable = true;
  };

  hardware = {
    pulseaudio.support32Bit = true;

    bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
    };
  };
}
