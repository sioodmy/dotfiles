{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.tmux;
in {
  options.modules.programs.tmux = { enable = mkEnableOption "tmux"; };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      keyMode = "vi";
      aggressiveResize = true;
      clock24 = true;
      plugins = with pkgs.tmuxPlugins; [ nord urlview extrakto ];
      extraConfig = ''
        set -g default-terminal "screen-256color"
        set -sa terminal-overrides ',xterm-256color:RGB'
        # so that escapes register immidiately in vim
        set -sg escape-time 1
        set -g focus-events on
        # mouse support
        set -g mouse on
        # change prefix to C-a
        set -g prefix C-a
        bind C-a send-prefix
        unbind C-b
        # extend scrollback
        set-option -g history-limit 5000
        # vim-like pane resizing
        bind -r C-k resize-pane -U
        bind -r C-j resize-pane -D
        bind -r C-h resize-pane -L
        bind -r C-l resize-pane -R
        # vim-like pane switching
        bind -r k select-pane -U
        bind -r j select-pane -D
        bind -r h select-pane -L
        bind -r l select-pane -R
        # styling
        set -g pane-active-border-style bg=default,fg=brightblack
        set -g pane-border-style fg=brightblack
      '';
    };
  };
}
