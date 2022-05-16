{ pkgs, lib, config, theme, ... }:
with lib;
let cfg = config.modules.cli.fzf;
in {
  options.modules.cli.fzf = { enable = mkEnableOption "fzf"; };

  config = mkIf cfg.enable {
    programs.zsh = {
      localVariables = with theme.colors; {
        FZF_DEFAULT_OPTS =
          "--color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
          --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
          --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
          --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'";
          };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = with theme.colors; [
        "--height 50%"
        "--color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1"
        "--color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1"
        "--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac"
        "--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'"
      ];
    };
  };
}
