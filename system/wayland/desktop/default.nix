{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.rose-pine-moon;

  environment.systemPackages = import ./wrapped.nix {inherit pkgs inputs config;};
}
