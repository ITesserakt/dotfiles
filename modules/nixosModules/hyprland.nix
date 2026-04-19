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
        withUWSM = false;
      };

      nix.settings.trusted-substituters = [
        "https://hyprland.cachix.org"
      ];
      nix.settings.trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      xdg.portal = {
        enable = true;
        extraPortals = [ hypr-pkgs.xdg-desktop-portal-hyprland ];
      };
    };
}
