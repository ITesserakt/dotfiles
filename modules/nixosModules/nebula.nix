{
  flake.nixosModules.nebula = {
    services.nebula.networks."mesh" = {
      enable = true;
      staticHostMap."172.16.100.1" = [ "77.221.141.112:4242" ];
      lighthouses = [ "172.16.100.1" ];
    };
  };
}
