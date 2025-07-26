{pkgs, ...}: let
  inherit (builtins) attrValues;
in {
  environment.sessionVariables.FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  fonts = {
    packages =
      attrValues {
        inherit
          (pkgs)
          material-icons
          material-design-icons
          roboto
          work-sans
          comic-neue
          source-sans
          twemoji-color-font
          comfortaa
          inter
          lato
          lexend
          jost
          dejavu_fonts
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-emoji
          ;
      }
      ++ [
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.maple-mono.NF
        # (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
      ];

    enableDefaultPackages = false;

    # this fixes emoji stuff
    fontconfig = {
      defaultFonts = {
        monospace = [
          "Maple Mono NF"
          "Noto Color Emoji"
        ];
        sansSerif = ["Lexend" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
