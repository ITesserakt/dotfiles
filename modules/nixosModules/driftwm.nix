{ self, ... }: {
  flake.nixosModules.driftwm = { pkgs, ... }: {
    services.displayManager.sessionPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.driftwm ];
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.driftwm ];
  };
}
