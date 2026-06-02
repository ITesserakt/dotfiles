{
  perSystem =
    { pkgs, ... }:
    let
      version = "1.5.0";
      wayshot-src = pkgs.fetchFromGitHub {
        owner = "waycrate";
        repo = "wayshot";
        rev = "v${version}";
        sha256 = "sha256-sbY3h3FoWxDmxSng9YvYpt3kyasVJGsykYC/7tblFn8=";
      };
    in
    {
      packages.wayshot = pkgs.rustPlatform.buildRustPackage {
        pname = "wayshot";
        inherit version;

        src = wayshot-src;

        nativeBuildInputs = with pkgs; [
          gnumake
          pkg-config
        ];

        buildInputs = with pkgs; [
          wayland
          glib
          pango
          libGL
          libjxl
          libgbm
        ];

        cargoHash = "sha256-J7ZKWx258bBCNBd061aCeKgTdcWMUF4yzAiIa9l8ZRA=";

        doCheck = false;
      };
    };
}
