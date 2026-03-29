{
  flake.nixosModules.mac-air = { lib, ... }: {
    services.desktopManager.gnome.enable = lib.mkForce false;

    services.xserver.xkb.options = lib.mkForce "grp:ctrl_space_toggle";
  };
}
