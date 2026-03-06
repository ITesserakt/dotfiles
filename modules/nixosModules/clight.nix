{
  flake.nixosModules.clight = {
    services.clight = {
      enable = true;
      settings = {
        dimmer.disabled = true;
        dmps.disabled = true;
        screen.disabled = true;
      };
      temperature.night = 4200;
    };
  };
}
