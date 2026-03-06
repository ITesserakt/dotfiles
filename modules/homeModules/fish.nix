{
  flake.homeModules.fish = { pkgs, lib, ... }: {
    programs.fish = {
      enable = true;
      shellAliases = {
        cat = lib.getExe pkgs.bat;
        nix-shell = "nix-shell --run fish";
      };
    };
  };
}
