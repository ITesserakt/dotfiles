{ withSystem, inputs, ... }:
{
  flake.overlays = {
    # replace broken packages with stable versions
    broken =
      final: prev:
      (withSystem prev.stdenv.hostPlatform.system (
        { system, ... }:
        let
          stable = import inputs.stable-nixpkgs {
            inherit system;
          };
          nightly = import inputs.nightly-nixpkgs {
            inherit system;
          };
        in
        {
          direnv = stable.direnv;
        }
      ));
  };
}
