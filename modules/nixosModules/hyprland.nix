{ inputs, ... }:
{
  flake.nixosModules.hyprland =
    { pkgs, ... }:
    let
      hypr-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      programs.hyprland = {
        enable = true;
        package = hypr-pkgs.hyprland;
        portalPackage = hypr-pkgs.xdg-desktop-portal-hyprland;
      };
    };
}
