{
  lib,
  pkgs,
  ...
}: ''
  #> Syntax: bash

  # Send to host

  [ -f "$1" ] && op="cat"
  ''${op:-echo} "''${@:-$(cat -)}" \
      | ${lib.getExe pkgs.curl} -sF file='@-' 'http://0x0.st' \
      | tee /dev/stderr \
      | tr -d '\n'      \
      | ${pkgs.wl-clipboard}/bin/wl-copy -n
''
