{
  flake,
  pkgs,
  ...
}: {
  users = {
    mutableUsers = false;
    users = {
      root.hashedPasswordFile = "/persist/secrets/root";
      sioodmy = {
        isNormalUser = true;
        homix = true;
        shell = flake.packages.${pkgs.system}.zsh;

        hashedPasswordFile = "/persist/secrets/sioodmy";
        extraGroups = [
          "wheel"
          "systemd-journal"
          "vboxusers"
          "audio"
          "plugdev"
          "wireshark"
          "video"
          "input"
          "lp"
          "networkmanager"
          "power"
          "nix"
          "adbusers"
        ];
        uid = 1000;
      };
    };
  };

  security = {
    sudo = {
      enable = true;
      extraRules = [
        {
          commands =
            builtins.map (command: {
              command = "/run/current-system/sw/bin/${command}";
              options = ["NOPASSWD"];
            })
            ["poweroff" "reboot" "nixos-rebuild" "nix-env" "bandwhich" "systemctl"];
          groups = ["wheel"];
        }
      ];
    };

    pam = {
      services = {
        login = {
          enableGnomeKeyring = true;
          fprintAuth = true;
        };
        sudo.fprintAuth = true;
        hyprlock.fprintAuth = true;
      };

      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];
    };
  };
}
