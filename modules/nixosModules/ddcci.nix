{
  flake.nixosModules.ddcci = { pkgs, config, ... }: {
    boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
    boot.kernelModules = [
      "ddcci-backlight"
      "i2c-dev"
    ];
    environment.systemPackages = [ pkgs.ddcutil ];
  };
}
