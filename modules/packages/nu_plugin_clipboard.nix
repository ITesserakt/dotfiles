{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.nu_plugin_clipboard =
        let
          version = pkgs.nushell.version;
        in
        pkgs.rustPackages.rustPlatform.buildRustPackage {
          src = pkgs.fetchFromGitHub {
            owner = "FMotalleb";
            repo = "nu_plugin_clipboard";
            rev = "v${version}";
            sha256 = "sha256-9SFQJJun/7Ze3+P4zNJu+U5VOjQiM5VfPieu+2fNIXA=";
          };
          name = "nu_plugin_clipboard";
          inherit version;

          cargoHash = "sha256-tJ+xxrQHvX2tk1CMSn1wL7VrnqA4znzaaBuD3oyrzx4=";

          meta.mainProgram = "nu_plugin_clipboard";
        };
    };
}
