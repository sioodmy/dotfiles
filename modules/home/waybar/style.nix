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
    background-color: #303446;
    border-radius: 0px;
    color: #c6d0f5;
    font-size: 16px;
    /* transition-property: background-color; */
    transition-duration: 0.5s;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #workspaces {
    background-color: #414559;
  }

  #pulseaudio {
    color: #a6d189;
  }

  #network {
    color: #8caaee;
  }

  #custom-weather,
  #clock {
    color: #c6d0f5;
    background-color: #414559;
  }

  #workspaces button {
    background-color: transparent;
    /* Use box-shadow instead of border so the text isn't offset */
    color: #8caaee;
    padding-left: 6px;
    box-shadow: inset 0 -3px transparent;
    transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
  }

  #workspaces button:hover {
    color: #85c1dc;
    box-shadow: inherit;
    text-shadow: inherit;
  }

  #custom-power {
      color: #e78284;
      margin: 7px;
      font-size: 24px;
  }

  #workspaces button.active {
    color: #e5c890;
    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
  }

  #workspaces button.urgent {
    background-color: #e78284;
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
  #custom-weather,
  #custom-btc,
  #custom-eth,
  #volume,
  #pulseaudio {
    border-radius: 15px;
    background-color: #414559;
    padding: 0px 10px 0px 10px;
    margin: 5px 0px 5px 0px;
  }

  #custom-swallow {
    color: #ca9ee6;
  }


  #custom-lock {
      color: #8caaee;
      padding: 0 20px 0 20px;
  }

  #custom-todo {
    color: #c6d0f5;
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
    color: #e5c890;
  }
  #battery {
    color: #a6d189;
  }

  #battery.warning {
    color: #ef9f76;
  }

  #battery.critical:not(.charging) {
    color: #e78284;
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
