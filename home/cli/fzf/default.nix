{ pkgs, lib, config, theme, ... }:
with lib;
let cfg = config.modules.cli.fzf;
in {
  options.modules.cli.fzf = { enable = mkEnableOption "fzf"; };

  config = mkIf cfg.enable {
    programs.zsh = {
      localVariables = with theme.colors; {
        FZF_DEFAULT_OPTS =
          "--color=fg+:#${c6},bg+:#${bg},fg:#${fg},info:#${c3},prompt:#${c6},pointer:#${c6}";
      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = with theme.colors; [
        "--height 50%"
        "--color=fg+:#${c6},bg+:#${bg},fg:#${fg},info:#${c3},prompt:#${c3},pointer:#${c6}"
      ];
    };
  };
}
