{
  flake.nixosModules.nvidia = { config, lib, ... }: {
    hardware.nvidia = {
      modesetting.enable = true;
      dynamicBoost.enable = true;

      powerManagement.enable = true;
      powerManagement.finegrained = true;

      prime.offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    services.xserver.videoDrivers = [ "nvidia" "modesetting" ];
    nixpkgs.config.nvidia.acceptLicense = true;
    nixpkgs.config.allowUnfree = lib.mkForce true;
  };
}
