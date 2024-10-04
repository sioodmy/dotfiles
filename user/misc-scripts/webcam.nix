pkgs:
pkgs.writeShellScriptBin "webcam" ''
  #!/bin/sh
  ${pkgs.mpv}/bin/mpv --profile=low-latency \
  --untimed \
  -vf=hflip \
  /dev/video0
''
