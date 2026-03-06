{
  flake.nixosModules.evolution =
    { pkgs, ... }:
    {
      programs.evolution = {
        enable = true;
        plugins = with pkgs; [ evolution-ews ];
      };
    };
}
