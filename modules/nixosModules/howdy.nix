{
  flake.nixosModules.howdy = {
    services.howdy.enable = true;
    services.linux-enable-ir-emitter.enable = true;
  };
}
