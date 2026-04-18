{ inputs, ... }:
{
  flake.homeModules.caelestia =
    { pkgs, ... }:
    let
      pkg-of = name: pkg: inputs.${name}.packages.${pkgs.stdenv.hostPlatform.system}.${pkg};
    in
    {
      imports = [
        inputs.caelestia-shell.homeManagerModules.default
      ];

      programs.caelestia = {
        enable = true;
        package = (pkg-of "caelestia-shell" "default").override {
          hyprland = pkg-of "hyprland" "hyprland";
        };
        systemd.enable = true;
      };
    };
}
