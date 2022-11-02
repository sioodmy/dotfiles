{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.tmux;
  catppuccin-tmux = pkgs.tmuxPlugins.mkTmuxPlugin rec {
    pluginName = "catppuccin";
    rtpFilePath = "catppuccin.tmux";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "8820440bb70e6b1a79fc372edad1c28e2a670528";
      sha256 = "tTev7pkB4U0ztSi49rQKHXmLdd5+V64qODpG2EaBGbw=";
    };
  };
in {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    aggressiveResize = true;
    clock24 = true;
    plugins =
      [
        {
          plugin = catppuccin-tmux;
          extraConfig = "set -g @catppuccin_flavour 'frappe'";
        }
      ]
      ++ (with pkgs.tmuxPlugins; [urlview extrakto]);
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides 'xterm-256color,*:Ss=\E[%p1%d q:Se=\E[2 q'
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
      bind-key -r I run-shell "tmux neww cht"
      # styling
      set -g pane-active-border-style bg=default,fg=brightblack
      set -g pane-border-style fg=brightblack
    '';
  };
}
