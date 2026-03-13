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

    hardware.asahi = {
      peripheralFirmwareDirectory = ./firmware;
      extractPeripheralFirmware = false;
      setupAsahiSound = true;
    };

    hardware.graphics.enable32Bit = lib.mkForce false;

    zramSwap = {
      enable = true;
      memoryPercent = 100;
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

    programs.dconf.profiles.user.databases = [{
      settings."org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer" ];
    }];
  };
}
