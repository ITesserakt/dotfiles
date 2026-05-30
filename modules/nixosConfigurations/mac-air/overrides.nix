{
  flake.nixosModules.mac-air = { lib, ... }: {
    services.xserver.xkb.options = lib.mkForce "grp:ctrl_space_toggle";

    services.keyd.keyboards.default.ids = [ "05ac:0351:c0152ca3" ];

    boot.loader.grub.efiSupport = lib.mkForce false;
  };
}
