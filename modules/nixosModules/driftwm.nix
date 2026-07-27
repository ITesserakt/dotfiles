{ inputs, ... }: {
  flake.nixosModules.driftwm = {
    imports = [
      inputs.driftwm.nixosModules.default
    ];

    programs.driftwm.enable = true;
  };
}
