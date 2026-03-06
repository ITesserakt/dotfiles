{
  flake.nixosModules.docker = {
    virtualisation.docker =
      let
        settings = {
          default-address-pools = [
            {
              base = "10.10.0.0/16";
              size = 24;
            }
          ];
          dns-search = [ ];
          dns-opts = [ ];
        };
      in
      {
        enable = true;
        rootless = {
          enable = true;
          setSocketVariable = true;
          daemon.settings = settings // {
            data-root = "/data/docker/rootless";
          };
        };
        daemon.settings = settings // {
          data-root = "/data/docker/root";
        };
        storageDriver = "btrfs";
      };
  };
}
