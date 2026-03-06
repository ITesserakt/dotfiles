{
  flake.nixosModules.zfs = { pkgs, ... }: {
    boot.zfs.package = pkgs.zfs_unstable;
    
    services.zfs.trim.enable = true;
    services.zfs.autoScrub.enable = true;
    services.zfs.autoSnapshot = {
      hourly = 4;
      frequent = 1;
      weekly = 1;
      enable = true;
    };
  };
}
