{
  flake.nixosModules.cosmic = {
    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;
    };

    services.displayManager.cosmic-greeter.enable = true;
  };
}
