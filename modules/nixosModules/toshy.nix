{ inputs, ... }:
{
  flake.nixosModules.toshy = {
    imports = [
      inputs.toshy.nixosModules.default
    ];

    services.toshy.enable = true;
    nixpkgs.overlays = [ inputs.toshy.overlays.default ];
  };
}
