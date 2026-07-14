{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.nixosConfigurations.mac-air = lib.nixosSystem {
    modules = with self.nixosModules; [
      appimage
      asahi
      base
      # self.modules.nixos.box64-binfmt
      beesd
      btrfs
      # driftwm
      extra-substituters
      filesystem
      hyprland
      mac-air
      nh
      nix
      pomme
      regreet
      stylix
      tailscale
      toshy-emulation
    ];
  };

  flake.nixosModules.mac-air =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      imports = [
        ./_hardware-configuration.nix
      ];

      system.stateVersion = "25.05";

      boot.loader.systemd-boot.enable = true;
      boot.loader.grub.enable = lib.mkForce false;
      boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
      boot.kernelParams = [
        "appledrm.show_notch=1"
      ];

      boot.supportedFilesystems = [ "apfs" ];
      # boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
      # nix.settings.extra-platforms = [ "x86_64-linux" ];
      # box64-binfmt.enable = false;

      # specialisation.fairydust.configuration.boot.kernelPackages = lib.mkForce (
      #   config.hardware.asahi.pkgs.linuxPackagesFor (
      #     config.hardware.asahi.pkgs.linux-asahi.kernel.overrideAttrs {
      #       src = pkgs.fetchFromGitHub {
      #         owner = "AsahiLinux";
      #         repo = "linux";
      #         rev = "f9f31e394acadb47e564a867a3538f6a87db956e";
      #         sha256 = "sha256-vT9uGCgi0uKssJ78bctBh8NNR2GnOIPICKtdU1+GQYE=";
      #       };
      #       version = "7.0.8";
      #     }
      #   )
      # );

      hardware.asahi = {
        peripheralFirmwareDirectory = ./firmware;
        extractPeripheralFirmware = false;
      };
      hardware.sensor.iio.enable = true;

      zramSwap = {
        enable = true;
        memoryPercent = 100;
        algorithm = "zstd";
      };

      services.udev.extraRules = ''KERNEL=="macsmc-battery", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="90", ATTR{charge_control_start_threshold}="70"'';
      services.tuned.enable = true;
    };
}
