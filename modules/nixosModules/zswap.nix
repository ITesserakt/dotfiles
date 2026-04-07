{
  flake.nixosModules.zswap = {
    boot.kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.max_pool_percent=20"
      "zswap.shrinker_enabled=1"
      "zswap.zpool=zsmalloc"
    ];

    boot.initrd.kernelModules = [
      "zstd"
      "zsmalloc"
    ];
  };
}
