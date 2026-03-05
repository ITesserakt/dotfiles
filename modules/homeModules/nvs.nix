{ inputs, ... }: {
  flake.homeModules.nvs = { pkgs, ... }: {
    home.packages = [
      inputs.nvs.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
