{
  pkgs,
  inputs,
  aliasesStr,
}:
pkgs.writeShellScriptBin ".zshrc" ''

  source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh

  source ${./starship.zsh}
  source ${./zoxide.zsh}

  source ${./config.zsh}

  zsh-defer source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
  zsh-defer source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
  zsh-defer source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
  zsh-defer source ${inputs.zsh-auto-notify}/auto-notify.plugin.zsh

  ${aliasesStr}
''
