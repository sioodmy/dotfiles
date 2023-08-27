{
  inputs,
  pkgs,
  ...
}: let
  anyrunPkgs = inputs.anyrun.packages.${pkgs.system};
in {
  programs.anyrun = {
    enable = true;

    config = {
      plugins = with anyrunPkgs; [
        applications
        rink
        symbols
        stdin
        inputs.cryptorun.packages.${pkgs.system}.default
      ];

      # width.fraction = 0.3;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = ''
      * {
        transition: 200ms ease-out;
        color: #cdd6f4;
        font-family: Lexend;
        font-size: 1.1rem;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      #match:selected {
        background: rgba(203, 166, 247, 0.5);
      }

      #match {
        padding: 3px;
        border-radius: 16px;
      }

      #entry {
        border-radius: 16px;
      }

      box#main {
        background: rgba(30, 30, 46, 0.5);
        border: 1px solid #28283d;
        border-radius: 24px;
        padding: 8px;
      }

      row:first-child {
        margin-top: 6px;
      }
    '';
  };
}
