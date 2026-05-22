{ self, lib, ... }:
{
  flake.nixosConfigurations.mac-air = lib.nixosSystem {
    modules = with self.nixosModules; [
      asahi
      base
      beesd
      btrfs
      extra-substituters
      filesystem
      gnome
      hyprland
      mac-air
      nebula
      nh
      nix
      pomme
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
      # boot.supportedFilesystems = [ "apfs" ];

      boot.kernelPackages = lib.mkForce (
        config.hardware.asahi.pkgs.linuxPackagesFor (
          config.hardware.asahi.pkgs.linux-asahi.kernel.overrideAttrs {
            src = pkgs.fetchFromGitHub {
              owner = "AsahiLinux";
              repo = "linux";
              rev = "f9f31e394acadb47e564a867a3538f6a87db956e";
              sha256 = "sha256-vT9uGCgi0uKssJ78bctBh8NNR2GnOIPICKtdU1+GQYE=";
            };
          }
        )
      );

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
