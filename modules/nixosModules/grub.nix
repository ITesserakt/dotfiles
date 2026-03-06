{
  flake.nixosModules.grub.boot = {
    loader.grub = {
      enable = true;
      useOSProber = true;
      configurationLimit = 10;
      default = "saved";
    };
  };
}
