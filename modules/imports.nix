{ inputs, ... }: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.flake-parts.flakeModules.modules
    inputs.devshell.flakeModule
    inputs.nixos-box64-binfmt.flakeModules.default
  ];
}
