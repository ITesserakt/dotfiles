{ inputs, ... }:
{
  perSystem =
    {
      system,
      pkgs,
      lib,
      ...
    }:
    let
      fenix = inputs.fenix.packages.${system};
      mkRustDevShell = toolchain: overrides: {
        packages = [
          toolchain.toolchain
          pkgs.stdenv.cc
        ]
        ++ (overrides.packages or [ ]);

        env = [
          {
            name = "RUST_SRC_PATH";
            value = "${toolchain.rust-src}";
          }
          {
            name = "RUST_TOOLCHAIN_PATH";
            value = "${toolchain.toolchain}";
          }
        ]
        ++ (overrides.env or [ ]);
      };
    in
    {
      devshells.rust = mkRustDevShell fenix.stable { };
      devshells.rust-nightly = mkRustDevShell fenix.latest { };

      devshells.rust-bevy = mkRustDevShell fenix.stable {
        packages = with pkgs; [
          pkg-config
          alsa-lib
          udev
          libX11
          libXcursor
          libXi
          wayland
          clang
          mold
        ];

        env = [
          {
            name = "LD_LIBRARY_PATH";
            prefix = lib.makeLibraryPath [
              pkgs.vulkan-loader
              pkgs.libxkbcommon
              pkgs.wayland
              pkgs.udev
            ];
          }
        ];
      };
    };
}
