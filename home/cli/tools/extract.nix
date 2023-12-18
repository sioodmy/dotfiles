_: ''
   SAVEIFS=$IFS
  IFS="$(printf '\n\t')"

  function extract {
   if [ $# -eq 0 ]; then
      # display usage if no parameters given
      echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso>"
      echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
   fi
      for n in "$@"; do
          if [ ! -f "$n" ]; then
              echo "'$n' - file doesn't exist"
              return 1
          fi

          case "''${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar zxvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar) unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip) unzip ./"$n"   ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar|*.vhd)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace) unace x ./"$n"     ;;
            *.zpaq)      zpaq x ./"$n"      ;;
            *.arc)       arc e ./"$n"       ;;
            *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                              extract "$n.iso" && \rm -f "$n" ;;
            *.zlib)      zlib-flate -uncompress < ./"$n" > ./"$n.tmp" && \
                              mv ./"$n.tmp" ./"''${n%.*zlib}" && rm -f "$n"   ;;
            *.dmg)
                        hdiutil mount ./"$n" -mountpoint "./$n.mounted" ;;
            *)
                        echo "extract: '$n' - unknown archive method"
                        return 1
                        ;;
          esac
      done
  }

  IFS=$SAVEIFS''
