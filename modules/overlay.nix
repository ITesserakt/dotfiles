{ withSystem, inputs, ... }:
{
  flake.overlays = {
    # replace broken packages with stable versions
    direnv =
      final: prev:
      (withSystem prev.stdenv.hostPlatform.system (
        { system, ... }:
        let
          stable = import inputs.stable-nixpkgs {
            inherit system;
          };
        in
        {
          direnv = stable.direnv;
        }
      ));

    clapper =
      final: prev:
      (withSystem prev.stdenv.hostPlatform.system (
        { system, ... }:
        let
          stable = import inputs.stable-nixpkgs {
            inherit system;
          };
        in
        {
          clapper = stable.clapper;
        }
      ));
  };
}
