{
  self,
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
      noctalia-greeter
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

      boot.supportedFilesystems = [ "apfs" ];

      # specialisation.fairydust.configuration.boot.kernelPackages = lib.mkForce (
      #   config.hardware.asahi.pkgs.linuxPackagesFor (
      #     config.hardware.asahi.pkgs.linux-asahi.kernel.overrideAttrs {
      #       src = pkgs.fetchFromGitHub {
      #         owner = "AsahiLinux";
      #         repo = "linux";
      #         rev = "e3e35907c17a05773d481e58a566bf9108166cc5";
      #         sha256 = "sha256-hmxu1NcS3Ce8VpJahgZLs7mjh3ZBHq3sW5NVO3DqglU=";
      #       };
      #       version = "7.1.5";
      #     }
      #   )
      # );

      hardware.asahi = {
        peripheralFirmwareDirectory = fetchTarball {
          url = "https://files.catbox.moe/xmujnw.xz";
          name = "firmware";
          sha256 = "sha256:1hhklc3m99l2xdqxl6imqkhihwpc18qrr2hddnxyfqa77xa906jr";
        };
        extractPeripheralFirmware = true;
      };
      hardware.sensor.iio.enable = true;

      zramSwap = {
        enable = true;
        memoryPercent = 50;
        algorithm = "zstd";
      };

      services.udev.extraRules = ''KERNEL=="macsmc-battery", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="90", ATTR{charge_control_start_threshold}="70"'';
      services.tuned.enable = true;
    };
}
