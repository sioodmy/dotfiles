{pkgs, ...}: let
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    # only suspend if audio isn't running
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        event = "lock";
        command = "${pkgs.gtklock}/bin/gtklock";
      }
    ];
    timeouts = [
      {
        timeout = 330;
        command = suspendScript.outPath;
      }
    ];
  };
  home.packages = with pkgs; [gtklock];

  xdg.configFile."gtklock/config.ini".text = ''
    [main]
    modules = ${pkgs.gtklock-powerbar-module}/lib/gtklock/powerbar-module.so;
  '';
  xdg.configFile."gtklock/style.css".text = ''
    * {
      color: white;
    }
    window {
      background: black;
      font-family: Product Sans;
    }

    grid > label {
      color: transparent;
      margin: -20rem;
    }

    button {
      all: unset;
      padding: 3rem;
    }
    #unlock-button label{
      color: transparent;
    }
    #message-box {
      all: unset;
      background-color: black;
    }

    #clock-label {
      font-size: 10rem;
      margin-bottom: 4rem;
      color: white;
    }

    entry {
      all: unset;
      border-radius: 30px;
      border: 2px solid white;
      padding: 2rem;
      font-size: 2rem;
      background-color: black;
    }
  '';
}
