{
  flake.nixosModules.beesd.services.beesd.filesystems.root = {
    spec = "/";
    hashTableSizeMB = 1024;
    verbosity = "info";
    extraOptions = [ "--thread-count" "4" ];
  };
}
