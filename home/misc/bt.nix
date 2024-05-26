{pkgs, ...}: let
  bt = pkgs.writeShellScriptBin "bt" ''
    #!/bin/sh

    MAC="AC:80:0A:E8:CF:28"
    connect=$(bluetoothctl info $MAC | grep Connected: | awk '{print $2}')

    if [[ $connect = no ]]; then
      notify-send "Bluetooth" "Attempting to connect"
      bluetoothctl connect $MAC || notify-send "Failed to Connect"
    elif [[ $connect = yes ]]; then
      notify-send "Bluetooth" "Attempting to disconnect"
      bluetoothctl disconnect $MAC
    fi
  '';
in {
  home.packages = [bt];
}
