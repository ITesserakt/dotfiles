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
      gaze
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
      specialisation.fairydust.configuration =
        { pkgs, config, ... }:
        let
          linux-fairydust-kernel = config.hardware.asahi.pkgs.linux-asahi.kernel.overrideAttrs {
            src = pkgs.fetchFromGitHub {
              owner = "AsahiLinux";
              repo = "linux";
              rev = "ce9f2eba72c061a50b2d790450e90af3439d8c24";
              sha256 = "sha256-W3yMSUe6xa+M/X0k86kbCS4g3d7jJmO3WV9L/5rQRhI=";
            };
            version = "7.1.13";
          };
          linux-fairydust = pkgs.linuxPackagesFor linux-fairydust-kernel;
        in
        {
          boot.kernelPackages = lib.mkForce linux-fairydust;
        };

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
