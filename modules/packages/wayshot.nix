{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.wayshot = pkgs.rustPlatform.buildRustPackage {
        pname = "wayshot";
        version = "${inputs.wayshot.lastModifiedDate}-git";

        src = inputs.wayshot;

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

        cargoHash = "sha256-nzByh3fkukptF5soFdRg+2YmEat9kvnbMvzkZFBGeAs=";

        doCheck = false;
      };
    };
}
