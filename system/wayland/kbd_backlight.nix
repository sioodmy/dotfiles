{pkgs, ...}: let
  keylit = pkgs.writeScriptBin "keylit" ''
    #!${pkgs.python3}/bin/python3

    def change(val):
        brightness = open("/sys/class/leds/kbd_backlight/brightness", "w")
        brightness.write(str(val))

    max_brightness = int(open("/sys/class/leds/kbd_backlight/max_brightness", "r").readline())
    brightness = int(open("/sys/class/leds/kbd_backlight/brightness", "r").readline())

    if brightness == 0:
        change(round(max_brightness/2))
    elif brightness == max_brightness:
        change(0)
    else:
        change(max_brightness)

  '';
in {
  environment.systemPackages = [
    keylit
  ];
}
