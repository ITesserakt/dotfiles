{ self, inputs, lib, ... }: {
  flake.nixosConfigurations.mac-air = lib.nixosSystem {
    modules = with self.nixosModules; [
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
    ];
  };

  flake.nixosModules.mac-air = { pkgs, ... }: {
    imports = [
      inputs.nixos-apple-silicon.nixosModules.default
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
      setupAsahiSound = true;
    };

    hardware.graphics.enable32Bit = lib.mkForce false;

    zramSwap = {
      enable = true;
      memoryPercent = 100;
      algorithm = "zstd";
    };

    networking = {
      networkmanager.wifi.backend = "iwd";
      wireless.iwd = {
        enable = true;
        settings.General.EnableNetworkConfiguration = true;
      };
    };

    environment.systemPackages = with pkgs; [
      asahi-bless
    ];

    services.udev.extraRules = ''KERNEL=="macsmc-battery", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="80", ATTR{charge_control_start_threshold}="70"'';

    services.power-profiles-daemon.enable = true;
  };
}
