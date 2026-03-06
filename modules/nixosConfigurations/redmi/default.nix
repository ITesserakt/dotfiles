{ self, lib, ... }:
{
  flake.nixosConfigurations.redmi = lib.nixosSystem {
    modules = with self.nixosModules; [
      appimage
      base
      beesd
      btrfs
      clight
      docker
      filesystem
      gnome
      grub
      hyprland
      kde-connect
      nh
      nix
      nvidia
      plymouth
      redmi
      stylix
      tailscale
      zfs
    ];
  };

  flake.nixosModules.redmi = {
    system.stateVersion = "24.05";

    boot.kernelModules = [
      "ddcci_backlight"
      "i2c-dev"
    ];
  };
}
