{ self, lib, ... }:
{
  flake.nixosConfigurations.mac-air = lib.nixosSystem {
    modules = with self.nixosModules; [
      asahi
      auto-cpufreq
      base
      beesd
      btrfs
      hyprland
      gnome
      mac-air
      nh
      nix
      pomme
      stylix
      tailscale
      toshy
    ];
  };

  flake.nixosModules.mac-air = {
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
  };
}
