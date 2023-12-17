let
  snowflake = builtins.fetchurl rec {
    name = "Logo-${sha256}.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
  };
in ''
    * {
      /* `otf-font-awesome` is required to be installed for icons */
      font-family: Material Design Icons, Lexend, Iosevka Nerd Font;
    }

    window#waybar {
      background-color: rgba(24, 24, 37, 0.65);
      border-radius: 0px;
  /*    margin: 32px 16px; */
      color: #cdd6f4;
      box-shadow: 2px 3px 2px 2px #151515;
      font-size: 14px;
      /* transition-property: background-color; */
      transition-property: background-color;
      transition-duration: 0.5s;
    }

    window#waybar.hidden {
      opacity: 0.2;
    }

    #pulseaudio {
      color: #a6d189;
    }

    #custom-vpn,
    #network {
      color: #ca9ee6;
    }

    #cpu {
      color: #ef9f76;
    }

    #memory {
      color: #fab387;
    }

    #clock {
      font-weight: 700;
      font-family: "Iosevka Term";
      padding: 0px 5px 0px 5px;
    }

    #workspaces button {
      background-color: transparent;
      /* Use box-shadow instead of border so the text isn't offset */
      color: #89b4fa;
      padding-left: 10px;
      box-shadow: inset 0 -3px transparent;
      transition: all 400ms cubic-bezier(0.250, 0.250, 0.555, 1.425);
    }

    #workspaces button:hover {
      color: #b4befe;
      box-shadow: inherit;
      text-shadow: inherit;
    }

    #custom-power {
        color: #f38ba8;
        padding: 0px 14px 0px 14px;
        margin-bottom: 20px;
    }

    #workspaces button.active {
      color: #f9e2af;
      transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
    }
    #workspaces button.urgent {
      background-color: #eba0ac;
    }
    #clock,
    #network,
    #custom-swallow,
    #cpu,
    #battery,
    #backlight,
    #memory,
    #workspaces,
    #custom-todo,
    #custom-lock,
    #custom-vpn,
    #custom-weather,
    #custom-power,
    #custom-crypto,
    #volume,
    #pulseaudio {
      border-radius: 8px;
      background-color: rgba(49, 50, 68, 0.35);
      padding: 0px 14px 0px 14px;
      margin: 3px 0px 3px 0px;
    }

    #custom-swallow {
      color: #94e2d5;
    }

    #custom-crypto {
      color: #89b4fa;
    }

    #custom-lock {
        color: #89b4fa;
    }

    #custom-search {
      background-image: url("${snowflake}");
      background-size: 65%;
      background-position: center;
      padding: 0 13px;
      background-repeat: no-repeat;
    }
    #backlight {
      color: #f9e2af;
    }
    #battery {
      color: #a6e3a1;
    }

    #battery.warning {
      color: #fab387;
    }

    #battery.critical:not(.charging) {
      color: #f38ba8;
    }
    tooltip {
      font-family: 'Lato', sans-serif;
      border-radius: 15px;
      padding: 20px;
      margin: 30px;
    }
    tooltip label {
      font-family: 'Lato', sans-serif;
      padding: 20px;
    }
''
