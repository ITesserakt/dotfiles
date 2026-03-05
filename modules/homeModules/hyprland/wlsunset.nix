{ config, ... }: {
  flake.homeModules.wlsunset.services.wlsunset = {
    enable = true;
    latitude = config.flake.meta.latitude;
    longitude = config.flake.meta.longitude;
    temperature.night = 4700;
  };
}
