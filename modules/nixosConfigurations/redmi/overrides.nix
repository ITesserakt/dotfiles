{
  flake.nixosModules.redmi = { lib, ... }: {
    networking.hostId = "14ea3ee7";
    networking.hostName = "redmi";

    hardware.nvidia.prime = {
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };

    services.desktopManager.gnome.enable = lib.mkForce false;
  };
}
