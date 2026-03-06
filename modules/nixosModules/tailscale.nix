{
  flake.nixosModules.tailscale = {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
      openFirewall = true;
    };
  };
}
