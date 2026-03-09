{ inputs, ... }:
{
  flake.homeModules.spotify =
    { pkgs, ... }:
    let
      spice-pkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      imports = [
        inputs.spicetify-nix.homeManagerModules.default
      ];

      programs.spicetify = {
        enable = false;
        enabledExtensions = with spice-pkgs.extensions; [
          adblock
        ];
      };

      home.packages = [
        pkgs.spotify
      ];
    };
}
