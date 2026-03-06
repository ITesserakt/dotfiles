{
  flake.nixosModules.steam = {
    programs.steam.enable = true;
    programs.gamemode.enable = true;
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
