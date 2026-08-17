{ inputs, ... }:
{
  flake.meta = {
    latitude = "55.771785";
    longitude = "37.695986";

    global-theme = "nord";

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

    mkNoctaliaPlugin =
      {
        name,
        extraDataFiles ? { },
      }:
      let
        basePath = "noctalia/plugins";
        mapAttrsToList = f: attrs: builtins.attrValues (builtins.mapAttrs f attrs);
        mapAttrs' = f: set: builtins.listToAttrs (mapAttrsToList f set);
        mapper = filename: value: {
          name = "${basePath}/data/noctalia/${name}/${filename}";
          inherit value;
        };
      in
      {
        xdg.stateFile = (mapAttrs' mapper extraDataFiles) // {
          "${basePath}/materialized/official/${name}" = {
            source = "${inputs.noctalia-plugins}/${name}";
            recursive = true;
          };
        };
      };
  };
}
