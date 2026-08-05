{ inputs, ... }:
{
  flake.meta = {
    latitude = "55.771785";
    longitude = "37.695986";

    font = {
      monospace = "Monaspace Krypton Var";
    };

    mkOverlay =
      overlay: final: prev:
      let
        system = prev.stdenv.hostPlatform.system;
        stable = import inputs.stable-nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        nightly = import inputs.nightly-nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      overlay { inherit stable nightly; };
  };
}
