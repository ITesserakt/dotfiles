{ inputs, ... }: {
  flake.homeModules.toshy = {
    imports = [
      inputs.toshy.homeManagerModules.default
    ];

    services.toshy = {
      enable = true;
      autoStart = true;
      enableGui = true;
    };
  };
}
