{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cli.git;
in {
  options.modules.cli.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.commitizen ];
    programs.git = {
      enable = true;
      userName = "sioodmy";
      userEmail = "sioodmy@tuta.io";
      extraConfig = {
        init = { defaultBranch = "main"; };
        delta = { syntax-theme = "ansi"; };
      };
      delta = { enable = true; };
      aliases = {
        co = "checkout";
        d = "diff";
        ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
        pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
        st = "status";
        br = "branch";
        c = "!cz commit";
        df =
          "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
        hist = ''
          log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all'';
        llog = ''
          log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative'';
        edit-unmerged =
          "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; vim `f`";
      };
    };

  };
}
