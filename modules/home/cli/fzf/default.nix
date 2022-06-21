{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.fzf;
in {
  options.modules.cli.fzf = { enable = mkEnableOption "fzf"; };

  config = mkIf cfg.enable {
    programs.zsh = {
      localVariables = {
        FZF_DEFAULT_OPTS = ''

          --color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'';
      };
    };

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
        defaultOptions = [
          "--height 50%"
          "--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"
        ];
      };
    };
}
