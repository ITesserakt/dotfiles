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
      driftwm
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

      specialisation.fairydust.configuration.boot.kernelPackages = lib.mkForce (
        config.hardware.asahi.pkgs.linuxPackagesFor (
          config.hardware.asahi.pkgs.linux-asahi.kernel.overrideAttrs {
            src = pkgs.fetchFromGitHub {
              owner = "AsahiLinux";
              repo = "linux";
              rev = "c83992242bc1e38bfc861a91696534479a2dbdf4";
              sha256 = "sha256-sGcgrrf/rpb8u9dvwiTFdNjp18UyuRhW94biH1WMO5I=";
            };
            version = "7.0.13";
          }
        )
      );

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
        memoryPercent = 100;
        algorithm = "zstd";
      };

      services.udev.extraRules = ''KERNEL=="macsmc-battery", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="90", ATTR{charge_control_start_threshold}="70"'';
      services.tuned.enable = true;
    };
}
