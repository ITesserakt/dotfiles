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
      nh
      nix
      pomme
      stylix
      tailscale
      toshy-emulation
    ];
  };

  flake.nixosModules.mac-air =
    { config, lib, ... }:
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

      boot.kernelPackages =
        let
          pkgs' = config.hardware.asahi.pkgs;
        in
        lib.mkForce (pkgs'.linux-asahi.override {
          _kernelPatches = config.boot.kernelPatches;
        });

      hardware.asahi = {
        peripheralFirmwareDirectory = ./firmware;
        extractPeripheralFirmware = false;
      };

      zramSwap = {
        enable = true;
        memoryPercent = 100;
        algorithm = "zstd";
      };

      services.udev.extraRules = ''KERNEL=="macsmc-battery", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="80", ATTR{charge_control_start_threshold}="70"'';
      services.tuned.enable = true;
    };
}
