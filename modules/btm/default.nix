{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.btm;
in {
  options.modules.programs.btm = {
    enable = mkEnableOption ''
      bottom, a cross-platform graphical process/system monitor with a
      customizable interface'';

    package = mkOption {
      type = types.package;
      default = pkgs.bottom;
      defaultText = literalExpression "pkgs.bottom";
      description = "Package providing <command>bottom</command>.";
    };

    # I had issues with home-manager's toml parser
    settings = mkOption {
      type = types.str;
      default = builtins.readFile ./bottom.toml;
      example = ''
        [colors]
        highlighted_border_color="#f4b8e4"
        border_color="#414559"
        graph_color="#c6d0f5"
        cursor_color="#f4b8e4"
        table_header_color="#f4b8e4"
        selected_bg_color="Magenta"
        [[row]]
          [[row.child]]
          type="cpu"
          ratio=3
          [[row.child]]
          type="mem"
          ratio=2
        [[row]]
            ratio=2
            [[row.child]]
              ratio=4
              default=true
              type="proc"
      '';
      description = ''
        Configuration written to
        <filename>$XDG_CONFIG_HOME/bottom/bottom.toml</filename> on Linux or
        <filename>$HOME/Library/Application Support/bottom/bottom.toml</filename> on Darwin.
        </para><para>
        See <link xlink:href="https://github.com/ClementTsang/bottom/blob/master/sample_configs/default_config.toml"/>
        for the default configuration.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."bottom/bottom.toml".text = cfg.settings;
  };
}
