{ inputs, ... }:
{
  flake.nixosModules.extra-substituters = {
    nix.settings = {
      extra-substituters = [ "https://vicinae.cachix.org" ];
      extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
    };
  };

  flake.homeModules.vicinae = {
    imports = [
      inputs.vicinae.homeManagerModules.default
    ];

    services.vicinae = {
      enable = true;
      systemd.enable = true;
      settings = {
        pop_to_root_on_close = true;
        launcher_window.blur.enabled = true;
      };
    };
  };
}
