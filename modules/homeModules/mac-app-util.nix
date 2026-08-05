
{ inputs, ... }: {
  flake.homeModules.mac-app-util = {
    imports = [
      inputs.mac-app-util.homeManagerModules.default
    ];
  };
}
