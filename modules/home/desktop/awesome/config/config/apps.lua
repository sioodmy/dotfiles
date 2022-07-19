terminal = os.getenv("TERMINAL") or "st"
search = "rofi -show drun"
files = "thunar"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
