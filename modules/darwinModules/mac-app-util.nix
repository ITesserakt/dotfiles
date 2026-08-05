{ inputs, ... }: {
  flake.modules.darwin.mac-app-util = {
    imports = [
      inputs.mac-app-util.darwinModules.default
    ];
  };
}
