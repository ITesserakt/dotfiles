{
  flake.nixosModules.mac-air = { lib, ... }: {
    services.desktopManager.gnome.enable = lib.mkForce false;
  };
}
