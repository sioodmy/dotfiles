theme: with theme.colors; ''
  * {
    font-family: Material Design Icons, Iosevka Nerd Font;
    padding: 0;
    margin: 0;
  }

  .module {
    border-radius: 12px;
    margin: 5px 1px 5px 1px;
    background-color: #414559;
    padding: 3px 10px;
  }

  window#waybar {
    background-color: #${base};
    border-radius: 0px;
    color: #${text};
    font-size: 16px;
    /* transition-property: background-color; */
    transition-duration: 0.5s;
  }

  #pulseaudio {
    color: #${green};
  }
  #network {
    color: #${blue};
  }
  #backlight {
    color: #${yellow};
  }
  #battery {
    color: #${green};
  }

  #battery.warning {
    color: #${maroon};
  }

  #battery.critical:not(.charging) {
    color: #${red};
  }

  #custom-search {
    background-image: url("${./sakura.png}");
    background-size: 60%;
    margin-left: 6px;
    background-position: center;
    background-repeat: no-repeat;
  }
  #clock {
    margin-right: 6px;
  }

  tooltip {
    font-family: sans-serif;
    border-radius: 15px;
    padding: 20px;
    margin: 30px;
  }
  tooltip label {
    font-family: sans-serif;
    padding: 20px;
  }
''
