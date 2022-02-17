{ pkgs, config, ...}:

{
    programs.discocss = {
        enable = true;
        css = builtins.readFile "${pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/catppuccin/discord/66f9c18c201331f28860ddf54c10eaa2d3ea5b15/Catppuccin.theme.css";
            sha256 = "72bcb8fa6c2025280f4cc5db6107faf826f113ba36f1beaaa5fdd2b444c481ec"; }
        }";
    };
}
