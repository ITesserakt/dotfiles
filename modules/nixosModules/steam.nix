{
  flake.nixosModules.steam = { lib, ... }: {
    programs.steam.enable = true;
    programs.gamemode.enable = true;
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
      ];
  };
}
