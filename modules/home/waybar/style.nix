let
  snowflake = builtins.fetchurl rec {
    name = "Logo-${sha256}.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
  };
in ''
  * {
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: Material Design Icons, Iosevka Nerd Font;
  }

  window#waybar {
    background-color: rgba(30, 30, 46, 0.7);
    border-radius: 0px;
    color: #cdd6f4;
    font-size: 16px;
    /* transition-property: background-color; */
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

  #workspaces button {
    background-color: transparent;
    /* Use box-shadow instead of border so the text isn't offset */
    color: #89b4fa;
    padding-left: 6px;
    box-shadow: inset 0 -3px transparent;
    transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
  }

  #workspaces button:hover {
    color: #b4befe;
    box-shadow: inherit;
    text-shadow: inherit;
  }

  #custom-power {
      color: #f38ba8;
      margin: 7px;
      font-size: 24px;
  }

  #workspaces button.active {
    color: #f9e2af;
    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
  }

  #workspaces button.urgent {
    background-color: #eba0ac;
  }
  #custom-weather,

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
  #custom-eth,
  #volume,
  #pulseaudio {
    border-radius: 15px;
    background-color: rgba(49, 50, 68, 0.8);
    padding: 0px 10px 0px 10px;
    margin: 5px 0px 5px 0px;
  }

  #custom-swallow {
    color: #94e2d5;
  }


  #custom-eth {
    color: #89b4fa;
  }

  #custom-lock {
      color: #89b4fa;
      padding: 0 20px 0 20px;
  }

  #custom-todo {
    color: #bac2de;
  }

  #custom-search {
    background-image: url("${snowflake}");
    background-size: 65%;
    padding: 0 15px 0 15px;
    margin: 5px;
    background-position: center;
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
