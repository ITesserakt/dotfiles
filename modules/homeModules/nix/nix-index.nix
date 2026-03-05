{ inputs, ... }:
{
  flake.homeModules.nix-index =
    { pkgs, ... }:
    {
      programs.nix-index = {
        enable = true;
        package = inputs.nix-index.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };
}
