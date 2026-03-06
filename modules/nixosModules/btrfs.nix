{
  flake.nixosModules.btrfs = {
    services.btrfs.autoScrub.enable = true;
  };
}
